# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skra/geo/version'

Gem::Specification.new do |spec|
  spec.name          = "skra-geo"
  spec.version       = Skra::Geo::VERSION
  spec.authors       = ["Aitor García"]
  spec.email         = ["aitor@linkingpaths.com"]
  spec.summary       = %q{Skra::Geo is a thin ruby wrapper to query WFS API of the [Icelandic National Registry](http://www.skra.is) Geoserver.}
  spec.homepage      = "https://github.com/linkingpaths/skra-geo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency('httparty', [">= 0.13.0"])

end
