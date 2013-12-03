$:.unshift File.expand_path("../", __FILE__)
require "#{File.join File.dirname(__FILE__)}/sinatra_server"
run Sinatra::Application