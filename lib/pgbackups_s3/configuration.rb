class PgbackupsS3
  @@configuration = nil

  def self.configure
    @@configuration = Configuration.new

    if block_given?
      yield configuration
    end

    configuration
  end

  def self.configuration
    @@configuration || configure
  end

  class Configuration
    attr_accessor :bucket, :directories, :access_key_id, :secret_access_key,
                  :capture_database, :restore_database

    def bucket
      @bucket ||= 'pgbackups_s3'
    end

    def directories
      @directories ||= 'backups'
    end

    def capture_database
      @capture_database ||= 'DATABASE_URL'
    end

    def restore_database
      @restore_database ||= 'DATABASE_URL'
    end
  end
end