# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pagaxian/version'

Gem::Specification.new do |spec|
  spec.name          = "pagaxian"
  spec.version       = Pagaxian::VERSION
  spec.authors       = ["Paul Gallagher"]
  spec.email         = ["gallagher.paul@gmail.com"]
  spec.description   = %q{A work-in-progress refactoring to a gem of my personal ajax pagination and search pattern using DataTables and kaminari}
  spec.summary       = %q{An ajax pagination and search pattern for Rails}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "kaminari"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'guard-minitest'
  spec.add_development_dependency 'rails',  '>= 3.1'

end
