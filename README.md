PgbackupsS3
=======================================

This gem allows you to send postgres dumps from Heroku to an S3 bucket. It also
allows you restore your current database from any of the backups on S3.

## Setup

To install on your system

`gem install pgbackups`

To install in rails app, add the following line to your Gemfile

`gem 'pgbackups_s3'`

Then run: `bundle install`

Then create the initialzer that will hold all the settings for the packups

`rails g pgbackups_s3:install`

Go to `config/initializers/pgbackups_s3.rb` and follow the documentation to get your backups cranking!

## Using the gem

### Back dat database up

To run a backup you can either run it in the rails console:

`PgbackupsS3.backup`

or through a rake task

`rake pgbackups_s3:backup`

### List all the backups for a certain day

To list all backups for today just run:

`PgbackupsS3.list_backups`

All the values will default to today if there is no input

To specify a specific day of backups, run:

`PgbackupsS3.list_backups(YEAR, MONTH, DAY)`

This command will print out the keys of all the backups

###