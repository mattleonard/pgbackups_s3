require 'httparty'
require 'pgbackups_s3/client'
require 'pgbackups_s3/configuration'

class PgbackupsS3
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load File.join(File.dirname(__FILE__), 'tasks/pgbackups_s3.rake')
    end
  end
end