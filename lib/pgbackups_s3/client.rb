class PgbackupsS3
  include HTTParty

  def initialize(args)
    uri = URI.parse(ENV['PGBACKUPS_URL'])
    host = "#{uri.scheme}://#{uri.host}"
    host += ":#{uri.port}" if uri.port
    p host
    self.class.base_uri = host
    self.class.basic_auth uri.user, uri.password
  end

  def get_latest_backup
    self.class.get('https://pgbackups.herokuapp.com:443/client/latest_backup')
  end
end