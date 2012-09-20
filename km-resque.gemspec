# -*- encoding: utf-8 -*-
require File.expand_path('../lib/km/resque/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Luke Melia"]
  gem.email         = ["luke@lukemelia.com"]
  gem.description   = %q{Interact with the KISSMetrics API via Resque}
  gem.summary       = %q{Interact with the KISSMetrics API via Resque}
  gem.homepage      = "https://github.com/lukemelia/km-resque"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "km-resque"
  gem.require_paths = ["lib"]
  gem.version       = KM::Resque::VERSION

  gem.add_dependency 'km', '>= 1.1.2'
  gem.add_dependency 'resque', '>= 1.1.0'
  gem.add_development_dependency 'resque_spec'
  gem.add_development_dependency 'webmock'
end
