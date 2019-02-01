if Rails.env.production?
    CarrierWave.configure do |config|
      config.aws_credentials = {
       # Configuration for Amazon AWS
  
      access_key_id:     ENV.fetch('AWS_ACCESS_KEY'),
      secret_access_key: ENV.fetch('AWS_SECRET_KEY'),
      region:            ENV.fetch('AWS_REGION') # Required
  }
      config.storage    = :aws
      config.aws_bucket = ENV.fetch('AWS_BUCKET')   
    end
  end
