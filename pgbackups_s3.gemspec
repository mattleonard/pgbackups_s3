Gem::Specification.new do |s|
  s.name        = 'pgbackups_s3'
  s.version     = '0.0.1'
  s.date        = '2014-07-25'
  s.summary     = %w{Send pgbackups to S3 using aws_sdk}
  s.description = %w{Send pgbackups to S3 using aws_sdk}
  s.authors     = ["Matt Leonard"]
  s.email       = 'mattleonardco@gmail.com'
  s.files       = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
  s.homepage    = 'http://mattl.co'
  s.license     = 'MIT'

  s.add_runtime_dependency 'aws-sdk', '>= 1.0'
  s.add_runtime_dependency 'httparty', '>= 0.3'
end