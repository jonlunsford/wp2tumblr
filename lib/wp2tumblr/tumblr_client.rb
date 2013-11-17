require "tumblr_client"
require "oauth"

module Wp2tumblr
  class TumblrClient
    attr_accessor :consumer_key, :secret_key, :access_token, :access_token_secret

    def initialize(consumer_key, secret_key, access_token, access_token_secret)
      @consumer_key = consumer_key
      @secret_key = secret_key
      @access_token = access_token
      @access_token_secret = access_token_secret
    end

    def connect
      Tumblr.configure do |config|
        config.consumer_key = @consumer_key
        config.consumer_secret = @secret_key
        config.oauth_token = @access_token
        config.oauth_token_secret = @access_token_secret
      end

      @client = Tumblr::Client.new(:client => :httpclient)
    end

    def text_posts(posts)
      posts.each do |post|
        @client.text("jonlunsford.tumblr.com", {:title => post[:title], :body => post[:content], :date => post[:created_at]})
      end
    end
  end
end