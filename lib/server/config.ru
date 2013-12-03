$:.unshift File.expand_path("../", __FILE__)
require './server_server'
run Sinatra::Application