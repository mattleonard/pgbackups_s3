namespace :pgbackups_s3 do
  task :setup => :environment do
    PgbackupsS3.setup
  end
  task :backup => :environment do
    PgbackupsS3.backup
  end
end