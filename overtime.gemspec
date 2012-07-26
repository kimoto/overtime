# -*- encoding: utf-8 -*-
require File.expand_path('../lib/overtime/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["kimoto"]
  gem.email         = ["sub+peerler@gmail.com"]
  gem.description   = %q{Time.parse can parse 'overtime' time format}
  gem.summary       = %q{Time.parse can parse 'overtime' time format}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "overtime"
  gem.require_paths = ["lib"]
  gem.version       = Overtime::VERSION
end
