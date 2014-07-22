require 'rest_client'

class PgbackupsS3

  def initialize(args)
    @client = URI.parse(ENV['PGBACKUPS_URL'])
  end

  def authenticated_resource(path)
    host = "#{@uri.scheme}://#{@uri.host}"
    host += ":#{@uri.port}" if @uri.port
    RestClient::Resource.new("#{host}#{path}",
      :user     => @uri.user,
      :password => @uri.password,
      :headers  => {:x_heroku_gem_version => Heroku::Client.version}
    )
  end

  def get_latest_backup
    resource = authenticated_resource("/client/latest_backup")
    json_decode get(resource).body
  end
end