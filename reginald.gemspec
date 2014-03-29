# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "reginald/version"

Gem::Specification.new do |spec|
  spec.name          = "reginald"
  spec.version       = Reginald::VERSION
  spec.authors       = ["goggin13"]
  spec.email         = ["goggin13@gmail.com"]
  spec.summary       = %q{A chat bot which hooks into both Twilio and XMPP}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "blather", "1.0.0"
  spec.add_dependency "sinatra", "1.4.4"
  spec.add_dependency "twilio-ruby", "3.11.5"
  spec.add_dependency "thin", "1.6.2"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "10.1.1"
  spec.add_development_dependency "rspec", "2.14.1"
  spec.add_development_dependency "rest-client", "1.6.7"
  spec.add_development_dependency "webmock", "1.17.4"
  spec.add_development_dependency "vcr", "2.8.0"
end
