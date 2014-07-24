PgbackupsS3.configure do |config|
  # Change this to the bucket you want the backups to go into
  config.bucket = 'YOUR_BUCKET_NAME'

  # This specifies the directories the backups will go in within your bucket
  # Ex. 'backups' will put all backups within your bucket in the backups folder
  config.directories = 'backups'

  # Input your amazon credentials
  config.access_key_id = 'YOUR_AWS_ACCESS_KEY',
  config.secret_access_key = 'YOUR_AWS_SECRET_ACCESS_KEY'
end