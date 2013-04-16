# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'converge/version'

Gem::Specification.new do |spec|
  spec.name          = "converge"
  spec.version       = Converge::VERSION
  spec.authors       = ["Victor Martinez"]
  spec.email         = ["knoopx@gmail.com"]
  spec.description   = %q{A convenient Rack middleware for flexible HTTP redirection}
  spec.summary       = %q{A convenient Rack middleware for flexible HTTP redirection}
  spec.homepage      = "https://github.com/knoopx/converge"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "addressable"
  spec.add_dependency "rack"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "activesupport", ">= 3.0.0"
end
