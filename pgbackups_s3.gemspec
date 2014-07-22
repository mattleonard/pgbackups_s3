Gem::Specification.new do |s|
  s.name        = 'pgbackups_s3'
  s.version     = '1.0.3'
  s.date        = '2010-04-28'
  s.summary     = %w{Send pgbackups to S3 using aws_sdk}
  s.description = %w{Send pgbackups to S3 using aws_sdk}
  s.authors     = ["Matt Leonard"]
  s.email       = 'mattleonardco@gmail.com'
  s.files       = ["lib/pgbackups_s3.rb", "lib/pgbackups_s3/client.rb"]
  s.homepage    = 'http://mattl.co'
  s.license     = 'MIT'

  s.add_runtime_dependency 'aws-sdk', '>= 1.0'
end