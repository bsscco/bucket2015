CarrierWave.configure do |config|
  access_key = ''
  secret_key = ''
  region = ''
  bucket = ''
  IO.foreach(File.dirname(__FILE__) + '/fog.config') do |line|
    puts line
    access_key = line.split('=')[1].strip if line.split('=')[0] == 'aws_access_key_id'
    secret_key = line.split('=')[1].strip if line.split('=')[0] == 'aws_secret_access_key'
    region = line.split('=')[1].strip if line.split('=')[0] == 'region'
    bucket = line.split('=')[1].strip if line.split('=')[0] == 'bucket'
  end

  config.fog_provider = 'fog/aws' # required
  config.fog_credentials = {
      provider: 'AWS', # required
      aws_access_key_id: access_key, # required
      aws_secret_access_key: secret_key, # required
      region: region, # optional, defaults to 'us-east-1'
  }
  config.fog_directory = bucket # required
end