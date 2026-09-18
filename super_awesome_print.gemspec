require_relative 'lib/super_awesome_print/version'

Gem::Specification.new do |spec|
  spec.name          = 'super_awesome_print'
  spec.version       = SuperAwesomePrint::VERSION
  spec.authors       = ['Oleg Antonyan']
  spec.email         = ['oleg.b.antonyan@gmail.com']

  spec.summary       = 'awesome_print wrapper that makes debug output easy to spot in long logs'
  spec.description   = 'Prints values with awesome_print, framed by colored markers, a timestamp and the caller location.'
  spec.homepage      = 'https://github.com/olegantonyan/super_awesome_print'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.7'

  spec.files         = Dir['lib/**/*.rb'] + %w[README.md LICENSE.txt]
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'awesome_print'

  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'rake'
end
