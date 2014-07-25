namespace :pgbackups_s3 do
  task :backup do
    PgbackupsS3.backup
  end
end