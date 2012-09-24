# -*- encoding: utf-8 -*-
require File.expand_path('../lib/untitled/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brendan Loudermilk"]
  gem.email         = ["bloudermilk@gmail.com"]
  gem.description   = %q{LOL}
  gem.summary       = %q{LOL}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "untitled"
  gem.require_paths = ["lib"]
  gem.version       = Untitled::VERSION

  gem.add_dependency "tilt", "~> 1.3.3"
  gem.add_dependency "rack", "~> 1.4.1"
  gem.add_dependency "sprockets", "~> 2.6.0"
end
