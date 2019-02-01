CarrierWave.configure do |config|
    if Rails.env.development?
      config.storage :file
      config.asset_host = 'http://localhost:3000'
    else
      config.storage = :fog
      config.fog_use_ssl_for_aws = true
      config.fog_directory  = ENV['FOG_DIRECTORY']
      config.fog_public     = true
      config.fog_attributes = { 'Cache-Control': 'max-age=315576000' }
      config.asset_host = 'https://s3.amazonaws.com/website'
  
      config.fog_credentials = {
        provider:               ENV['FOG_PROVIDER'],
        aws_access_key_id:      ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key:  ENV['AWS_SECRET_ACCESS_KEY'],
        path_style:             ENV['FOG_PATH_STYLE']
      }
    end
  end