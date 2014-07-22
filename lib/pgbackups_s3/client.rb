require 'httparty'

class PgbackupsS3
  include HTTParty

  def initialize
    @uri = URI.parse(ENV['PGBACKUPS_URL'])
    host = "#{@uri.scheme}://#{@uri.host}"
    host += ":#{@uri.port}" if @uri.port
    self.base_uri = host
    self.class.basic_auth @uri.user, @uri.password
  end

  def get_latest_backup
    self.class.get('/client/latest_backup')
  end
end