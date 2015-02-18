# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'specs_watcher/version'

Gem::Specification.new do |spec|
  spec.name          = "specs_watcher"
  spec.version       = SpecsWatcher::VERSION
  spec.authors       = ["Aaron Ortbals"]
  spec.email         = ["aaron.ortbals@gmail.com"]
  spec.summary       = %q{A useful CLI for searching Spec's online inventory}
  spec.homepage      = "https://vault.aaronortbals.com/aortbals/specs_watcher"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "typhoeus", "~> 0.7"
  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_dependency "thor", "~> 0.19"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency 'webmock', '~> 1.20'
  spec.add_development_dependency 'pry', '~> 0'
end
