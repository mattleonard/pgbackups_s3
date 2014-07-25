namespace :pgbackups_s3 do
  task :backup => :environment do
    PgbackupsS3.backup
  end
end