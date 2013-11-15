# encoding: utf-8
require 'spec_helper'
describe Wp2tumblr do
  it "depends on Nokogiri" do
    Nokogiri.should_not be_nil
  end
end