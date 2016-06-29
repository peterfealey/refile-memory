# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'refile/shopify/version'

Gem::Specification.new do |spec|
  spec.name          = "refile-shopify"
  spec.version       = Refile::Shopify::VERSION
  spec.authors       = ["Peter Fealey"]
  spec.email         = ["peter.fealey@me.com"]
  spec.summary       = %q{Shopify backend for Refile}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  spec.add_dependency "refile"

  spec.add_development_dependency "webmock", "~> 1.20.4"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
