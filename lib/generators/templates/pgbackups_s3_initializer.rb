PgbackupsS3.configure do |config|
  # Databases that you want data to be pulled from and restored to.
  # Defaults to 'DATABASE_URL'
  # Example of other is 'HEROKU_POSTGRESQL_GRAY_URL'
  # config.capture_database = 'DATABASE_URL'
  # config.restore_databse = 'DATABASE_URL'

  # Change this to the S3 bucket name you want the backups to go into
  # config.bucket = 'YOUR_BUCKET_NAME'

  # This specifies the directories the backups will go in within your bucket
  # Ex. 'backups' will put all backups within your bucket in the backups folder
  # config.directories = 'backups'

  # Input your amazon credentials
  # Required
  config.access_key_id = 'YOUR_AWS_ACCESS_KEY',
  config.secret_access_key = 'YOUR_AWS_SECRET_ACCESS_KEY'
end