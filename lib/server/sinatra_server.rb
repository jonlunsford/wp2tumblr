require "sinatra"

get "/callback" do
  puts "Your oauth_verifier token: #{params[:oauth_verifier]}"
end