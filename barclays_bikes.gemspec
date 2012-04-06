require File.expand_path('../lib/barclays_bikes/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = 'barclays_bikes'
  gem.version = BarclaysBikes::VERSION.dup
  gem.authors = ['Harry Marr']
  gem.email = ['harry@hmarr.com']
  gem.summary = 'A Ruby library for retrieving Barclays Bike availability'
  gem.homepage = 'https://github.com/hmarr/barclays_bikes'

  gem.files = `git ls-files`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
end
