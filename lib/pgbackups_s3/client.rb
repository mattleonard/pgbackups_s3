class PgbackupsS3
  include HTTParty


  def self.backup
    p = new
    p.capture
    p.get_latest_backup
    p.download
    p.send_to_s3
    p.clean
  end

  def self.list_backups(year=nil, month=nil, day=nil)
    p = new
    year ||= Date.today.year
    month ||= Date.today.month
    day ||= Date.today.day
    p.list_backups(year, month, day)
  end

  def self.restore(key)
    p = new
    p.restore_from(key)
  end

  def initialize
    uri = URI.parse(ENV['PGBACKUPS_URL'])
    @host = "#{uri.scheme}://#{uri.host}"
    @host += ":#{uri.port}" if uri.port
    self.class.basic_auth uri.user, uri.password
    @backup_url = ""
    @tmp_file = "./tmp/#{DateTime.now.strftime('%k:%M:%S')}.dump"
    @bucket = PgbackupsS3.configuration.bucket
    @directories = PgbackupsS3.configuration.directories
    @capture_database = PgbackupsS3.configuration.capture_database
    @restore_database = PgbackupsS3.configuration.restore_database
    File.new(@tmp_file, 'w+')

    @s3 = AWS::S3.new(
      access_key_id:  PgbackupsS3.configuration.access_key_id,
      secret_access_key: PgbackupsS3.configuration.secret_access_key
    )
  end

  def get_latest_backup
    @backup_url = self.class.get("#{@host}/client/latest_backup")['public_url']
  end

  def capture
    params = {:from_url => ENV[@capture_database], :from_name => ENV[@capture_database], :to_url => nil, :to_name => 'BACKUP', expire: true}
    backup = self.class.post("#{@host}/client/transfers", query: params)

    print "Wrangling up that postgres\n"

    until backup["finished_at"]
      print '.'
      sleep 1
      backup = self.class.get("#{@host}/client/transfers/#{backup['id']}")
    end

    print "\nYar we got it!\n"
  end

  def download
    print "Downloading that postgres\n"
    File.open(@tmp_file, "wb") do |output|
      streamer = lambda do |chunk, remaining_bytes, total_bytes|
        print '.'
        output.write chunk
      end
      Excon.get(@backup_url, :response_block => streamer)
    end
    print "\nSaved as #{@tmp_file} on local server\n"
  end

  def send_to_s3
    print "Shipping that sucka to S3\t"
    key = File.basename(@tmp_file)
    object = @s3.buckets[@bucket]
                .objects["#{@directories}/#{Date.today.year}/#{Date.today.month}/#{Date.today.day}/#{key}"]
                .write(:file => @tmp_file)
    object.acl = :private
    puts "Backup uploaded to #{@bucket} bucket."
  end

  def clean
    print "Removing backup from local server\n"
    File.delete(@tmp_file)
  end

  def list_backups(year, month, day)
    prefix = "#{@directories}/#{year}/#{month}/#{day}"
    keys = @s3.buckets[@bucket].objects.with_prefix(prefix).collect(&:key)

    print "Backups for #{month}-#{day}-#{year} ----------------------- \n"
    keys.each do |key|
      print "-- #{key} \n"
    end
  end

  def restore_from(key)
    print "\n\nWARNING: This will overwrite the production database with restore: #{key}\n"
    print "Type 'Give me my data!' to confirm \n"

    input = gets.chomp

    if input == 'Give me my data!'
      object = @s3.buckets[@bucket].objects.with_prefix(key).first
      object.acl = :public_read
      params = {:to_url => ENV[@restore_database], :to_name => ENV[@restore_database], :from_url => object.public_url, :from_name => "EXTERNAL_BACKUP"}
      backup = self.class.post("#{@host}/client/transfers", query: params)
      sleep 20
      object.acl = :private

      print "Database restore is being run in the background. Check your apps logs for more info"
    else
      print "Not overwriting your data. Phew that was a close one!"
    end
  end
end