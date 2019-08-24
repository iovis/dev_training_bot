lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dev_training_bot/version'

Gem::Specification.new do |spec|
  spec.name          = 'dev_training_bot'
  spec.version       = DevTrainingBot::VERSION
  spec.authors       = ['David Marchante']
  spec.email         = ['david.marchante@rubiconmd.com']

  spec.summary       = 'Create a poll in Slack with the proposed topics'
  spec.homepage      = 'https://github.com/iovis/dev_training_bot'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'chronic', '~> 0.10'
  spec.add_runtime_dependency 'google-api-client', '~> 0.23'
  spec.add_runtime_dependency 'launchy', '~> 2.4'
  spec.add_runtime_dependency 'slack-ruby-client', '~> 0.11'
  spec.add_runtime_dependency 'thor', '~> 0.20'
  spec.add_runtime_dependency 'dotenv', '~> 2.7'

  spec.add_development_dependency 'awesome_print', '~> 1.8'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'factory_bot', '~> 5.0'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'pry', '~> 0.11'
  spec.add_development_dependency 'pry-byebug', '~> 3.6'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 3.4'
end
