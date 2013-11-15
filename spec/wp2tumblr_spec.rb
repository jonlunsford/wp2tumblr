# encoding: utf-8
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
      puts Wp2tumblr::Wordpress.parse_posts
      # parsed_params = Wp2tumblr::Wordpress.parse_posts(file)
      # parsed_params[0][:title].should eq("Post Title")
    end
  end

  # describe ".parse_xml" do
  #   it "delegates parsing of just post categories" do
  #     parsed_params = Wordpress.parse_xml(file, :categories)
  #     parsed_params[0].should eq("Category 1")
  #   end
  # end

  # describe ".parse_xml" do 
  #   it "delegates parsing of just post tags" do 
  #     parsed_params = Wordpress.parse_xml(file, :tags)
  #     parsed_params[0].should eq("Tag 1")
  #   end
  # end

  # describe ".parse_xml" do 
  #   it "Parses posts, tags, categories, and comments together" do 
  #     parsed_params = Wordpress.parse_xml(file, :all)
  #     parsed_params[0][:title].should eq("Post Title")
  #     parsed_params[0][:tags][0].should eq("Tag 1")
  #     parsed_params[0][:categories][0].should eq("Category 1")
  #     parsed_params[0][:comments][0][:author].should eq("Test Commenter")
  #   end
  # end
end