if Rails.env.production?
    CarrierWave.configure do |config|
      config.aws_credentials = {
       # Configuration for Amazon S3
  
      access_key_id:     ENV.fetch('S3_ACCESS_KEY'),
      secret_access_key: ENV.fetch('S3_SECRET_KEY'),
      region:            ENV.fetch('S3_REGION') # Required
  }
      config.storage    = :aws
      config.aws_bucket = ENV.fetch('S3_BUCKET')  
    end
  end
