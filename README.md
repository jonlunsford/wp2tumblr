# Wp2tumblr
[![Gem Version](https://badge.fury.io/rb/wp2tumblr.png)](http://badge.fury.io/rb/wp2tumblr)

A CLI tool to import wordpress xml files into Tumblr via the Tumblr api

## Installation

    $ gem install wp2tumblr

## Usage

#### Config 
Before you will be able to import your posts into Tumblr you will need to configure your Tumblr API credentials.

    $ wp2tumblr config

You will be asked to register your application, provide your application's secret and public keys, and obtain an oauth_verifier token.

### Server
`wp2tumblr` includes a small Sinatra server to aid in collecting your oauth_verifier token. When you register your application just give it the callback url `http://localhost:9292/callback`, open up a seprate terminal window or session and run:

    $ wp2tumblr server

Now when you visit the redirect url you're given from `wp2tumblr config` you will see the oauth_verifier in your console.

### Import
Once you have completed the config process simply run the following command:

    $ wp2tumblr text -b myblog.tumblr.com -f ~/path/to/my/wordpress/export/file

the `text` command tells `wp2tumblr` to import all of the wordpress posts as type "text". Currently "text" is the only option. Since there is no dirrect correlation between wordpress post types and Tumblr post types, text is the default. Future iterations (pull requests are welcome), will allow you to import different Tumblr post types.

The `-b` option is the Tumblr blogs' name you will be importing to, ex. `myblog.tumblr.com`.

The `-f` option is the absolute path to your wordpress export file, ex. `~/Downloads/wordpress_export.xml`.

`wp2tumblr` will sleep one second between each post to not overload the Tumblr api. You will also see feedback stating how many posts were parsed from the wordpress export file as well as the title of each post that is currently being submitted to the Tumblr api.

## Changelog
- **Version 0.1.2:** Minor Feature, added server to help capture the oauth_verifier token
- **Version 0.1.1:** Refactored config process
- **Version 0.1.0:** Minor Feature, added Base64 encoding of images
- **Version 0.0.1:** Initial Release

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
