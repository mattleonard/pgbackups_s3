PgbackupsS3
=======================================

This gem allows you to send postgres dumps from Heroku to an S3 bucket. It also
allows you restore your current database from any of the backups on S3.

## Setup

To install on your system

`gem install pgbackups_s3`

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

This command will print out the keys of all the backups like so:

<pre><code>Backups for 7-25-2014 -----------------------
-- backups/2014/7/25/21:16:14.dump
-- backups/2014/7/25/21:17:52.dump
-- backups/2014/7/25/21:19:00.dump
-- backups/2014/7/25/21:19:43.dump
-- backups/2014/7/25/21:20:22.dump
-- backups/2014/7/25/21:21:32.dump
-- backups/2014/7/25/21:22:13.dump
</code></pre>

### To restore from a backup

WARNING: This will wipe out all data in your specified restore database, 'DATABASE_URL' is the default, with the backup.

Take one of the above keys and enter it as the param for the following function

`PgbackupsS3.restore('backups/2014/7/25/21:22:13.dump')`

You will have to confirm the restore but the database specified will be overwritten with your backup data.

## Contributions

Feel free to contribute or improve the code. Just fork the repo and open a pull request with you code. Also if you there are any issues just go ahead and create a new issue.

## License

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
