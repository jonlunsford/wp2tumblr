require "open-uri"
require "wp2tumblr/config"
require "wp2tumblr/wordpress"
require "wp2tumblr/tumblr_client"

module Wp2tumblr
  autoload :VERSION, File.join(File.dirname(__FILE__), "wp2tumblr/version");

  include Wp2tumblr::Wordpress
end
