# Wp2tumblr

A CLI tool to import wordpress xml files into Tumblr via the Tumblr api

## Installation

    $ gem install wp2tumblr

## Usage
This gem is dependant on the `~/.tumblr` config file that the [tumblr_client gem](https://github.com/tumblr/tumblr_client) generates. If you have not previously installed the [tumblr_client gem](https://github.com/tumblr/tumblr_client) and have run the [irb console setup](https://github.com/tumblr/tumblr_client#the-irb-console) you will be prompted to do so upon first use of this gem.

### Import
Once you have completed the config process simply run the following command:

  $ wp2tumblr text -b myblog.tumblr.com -f ~/path/to/my/wordpress/export/file

the `text` command tells `wp2tumblr` to import all of the wordpress posts as type "text". Currently "text" is the only option. Since there is no dirrect correlation between wordpress post types and Tumblr post types, text is the default. Future iterations (pull requests are welcome), will allow you to import different Tumblr post types.

The `-b` option is the Tumblr blogs' name you will be importing to, ex. `myblog.tumblr.com`.

The `-f` option is the absolute path to your wordpress export file, ex. `~/Downloads/wordpress_export.xml`.

`wp2tumblr` will sleep one second between each post to not overload the Tumblr api. You will also see feedback stating how many posts were parsed from the wordpress export file as well as the title of each post that is currently being submitted to the Tumblr api.

## Configuration Tips

If you're starting completely from scratch with Tumblr here is a basic outline of the steps to take after you have installed this gem.

#### Register an Application with Tumblr
go to [Tumblr Apps](http://www.tumblr.com/oauth/apps), create your application and take note of your OAuth Consumer Key as well as your Consumer Secret Key. You will need to register a callback url to get your `oauth_verifier` token, I created a [Sinatra](https://github.com/sinatra/sinatra) app for this at `http://localhost:4567/callback`.

#### Configure the Tumblr Client
Once you have your application token's run:
  
    $ tumblr

You will be prompted to enter your OAuth Consumer key, then your OAuth Consumer Secret. The [tumblr_client gem]('https://github.com/tumblr/tumblr_client') will then output an authorize url, copy and paste that into your browser and your callback url will receive the `oauth_verifier` post containing the OAuth Verifier token.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
