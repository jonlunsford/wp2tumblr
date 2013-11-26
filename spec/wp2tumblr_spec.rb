require 'spec_helper'

describe Wp2tumblr do
  context "Dependencies" do
    it "depends on Nokogiri" do
      Nokogiri.should_not be_nil
    end

    it "depends on tumblr_client" do
      Tumblr.should_not be_nil
    end

    it "depends on oauth" do
      OAuth.should_not be_nil
    end
  end
end

describe Wp2tumblr::Wordpress do
  let(:file) { File.open(File.dirname(__FILE__) + "/wp2tumblr/wordpress_format.xml") }

  describe ".parse_xml" do
    it "delegates parsing of just post content" do
      parsed_params = Wp2tumblr::Wordpress.parse_xml(file, :posts)
      parsed_params[0][:title].should eq("Post Title")
    end
  end

  describe ".parse_xml" do
    it "delegates parsing of just post categories" do
      parsed_params = Wp2tumblr::Wordpress.parse_xml(file, :categories)
      parsed_params[0].should eq("Category 1")
    end
  end

  describe ".parse_xml" do 
    it "delegates parsing of just post tags" do 
      parsed_params = Wp2tumblr::Wordpress.parse_xml(file, :tags)
      parsed_params[0].should eq("Tag 1")
    end
  end

  describe ".parse_xml" do 
    it "Parses posts, tags, categories, and comments together" do 
      parsed_params = Wp2tumblr::Wordpress.parse_xml(file, :all)
      parsed_params[0][:title].should eq("Post Title")
      parsed_params[0][:tags][0].should eq("Tag 1")
      parsed_params[0][:categories][0].should eq("Category 1")
      parsed_params[0][:comments][0][:author].should eq("Test Commenter")
    end
  end

  describe ".parse_images" do
    it "Encodes images as base64" do
      posts = Wp2tumblr::Wordpress.parse_xml(file, :posts)
      post = Nokogiri::HTML(posts[0][:content].text)
      Wp2tumblr::Wordpress.parse_images(post).to_s.should include('base64')
    end
  end
end

describe Wp2tumblr::TumblrClient do
  # config.yml is excluded from this repo, you must provide your own keys for deveopment purposes.
  let(:config) { YAML.load_file(File.dirname(__FILE__) + "/wp2tumblr/config_spec.yml") }
  let(:client) { Wp2tumblr::TumblrClient.new(config["tumblr_consumer_key"], config["tumblr_secret_key"], config["oauth_token"], config["oauth_token_secret"]) }
  let(:file) { File.open(File.dirname(__FILE__) + "/wp2tumblr/wordpress_format.xml") }

  describe "initialize" do
    it "should return an instance of itself" do
      client.should_not be_nil
    end
  end

  describe "authenticate" do
    it "should complete the oauth protocol with Tumblr" do
      tumblr_client = client.connect
      tumblr_client.should_not be_nil
    end
  end

  describe "text_posts" do
    it "should post text posts to the Tumblr api" do 
      posts = Wp2tumblr::Wordpress.parse_xml(file, :posts)
      client.connect
      client.text_posts(config["tumblr_blog_name"], posts)
    end
  end
end

describe Wp2tumblr::Config do
  it "saves API credentials to a YAML file." do
    api_config = {
      :consumer_key => "CONSUMER_KEY",
      :consumer_secret => "CONSUMER_SECRET",
      :oauth_token => "OAUTH_TOKEN",
      :oauth_token_secret => "OAUTH_TOKEN_SECRET"
    }

    Wp2tumblr::Config.save_api_credentials(api_config, ".wp2tumblr_spec")
    config = YAML.load_file File.join ENV['HOME'], '.wp2tumblr_spec'
    config["consumer_key"].should eq("CONSUMER_KEY");
  end
end