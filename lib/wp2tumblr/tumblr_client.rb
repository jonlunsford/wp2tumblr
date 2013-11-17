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

    def text_posts(blog_name, posts)
      puts "#{posts.count} posts found..."
      posts.each do |post|
        puts "Now posting: #{post[:title]}"
        @client.text(blog_name, {:title => post[:title], :body => post[:content], :date => post[:created_at]})
        sleep 1
      end
    end
  end
end