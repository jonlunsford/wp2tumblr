module Wp2tumblr
  module Config

     VALID_OPTIONS_KEYS = [
      :consumer_key,
      :consumer_secret,
      :oauth_token,
      :oauth_token_secret
    ]
    
    def self.save_api_credentials(credentials, file_name)
      File.open(File.join(ENV['HOME'], file_name), "w") do |f|
        configuration = {}
        VALID_OPTIONS_KEYS.each do |key|
          configuration[key.to_s] = credentials[key]
        end
        f.write YAML.dump configuration
      end
    end
  
  end
end