require "sinatra"

get "/callback" do
  puts params
end