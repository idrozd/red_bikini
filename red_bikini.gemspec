# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'red_bikini/version'

Gem::Specification.new do |spec|
  spec.name          = "red_bikini"
  spec.version       = RedBikini::VERSION
  spec.authors       = ["Andrey Titov"]
  spec.email         = ["terracote@gmail.com"]
  spec.description   = %q{think of public_exec:}
  spec.summary       = %q{ instance_exec run on wrapped receiver, with respect to private methods and setter aliases}
  spec.homepage      = "https://github.com/idrozd/red_bikini"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  #spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
end
