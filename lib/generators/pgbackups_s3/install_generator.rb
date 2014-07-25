class PgbackupsS3
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)
      desc "Creates PgbackupsS3 initialzier for your application"

      def copy_initializer
        template "pgbackups_s3_initializer.rb", "config/initializers/pgbackups_s3.rb"

        puts "Your data is almost safe! Just fill out the 'config/initializers/pgbackups_s3.rb' and you'll be good to go"
      end
    end
  end
end