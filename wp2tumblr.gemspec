# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wp2tumblr/version'

Gem::Specification.new do |spec|
  spec.name          = "wp2tumblr"
  spec.version       = Wp2tumblr::VERSION
  spec.authors       = ["jonlunsford"]
  spec.email         = ["jon@capturethecastle.net"]
  spec.description   = %q{A CLI tool}
  spec.summary       = %q{Import wordpress xml files into Tumblr via the Tumblr api}
  spec.homepage      = "https://github.com/jonlunsford/wp2tumblr"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "oauth"
  spec.add_dependency "tumblr_client"
  spec.add_dependency "nokogiri"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
end
