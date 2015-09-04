# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'super_awesome_print/version'

Gem::Specification.new do |spec|
  spec.name          = "super_awesome_print"
  spec.version       = SuperAwesomePrint::VERSION
  spec.authors       = ["Oleg Antonyan"]
  spec.email         = ["oleg.b.antonyan@gmail.com"]

  spec.summary       = %q{Simple wrapper around awesome_print for easier look in long log}
  spec.description   = %q{Add colored '*********', time and line number around printed value}
  spec.homepage      = "http://github.com/olegantonyan/super_awesome_printsuper_awesome_print"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = " Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "awesome_print"
end
