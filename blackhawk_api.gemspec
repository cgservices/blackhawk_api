# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blackhawk_api/version'

Gem::Specification.new do |spec|
  spec.name          = "blackhawk_api"
  spec.version       = BlackhawkApi::VERSION
  spec.authors       = ["Michael Siroen"]
  spec.email         = ["msiroen@cg.nl"]

  spec.summary       = "Ruby library for BlackHawk Network"
  spec.description   = "Ruby library for BlackHawk Network"
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  # spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  # Testing
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "brakeman"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "simplecov-rcov"
  spec.add_development_dependency "rspec_junit_formatter"
  # Cyclomatic Complexity
  spec.add_development_dependency "flog", "~> 4.3", ">= 4.3.2"
  # Code duplication
  spec.add_development_dependency "flay", "~> 2.6", ">= 2.6.1"
    # Static Code Analyzer
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-checkstyle_formatter"
  
  # Debugging
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-remote"
  spec.add_development_dependency "pry-nav"
  
  spec.add_dependency 'rubyntlm', '~> 0.3.2'
  spec.add_dependency "httpi", '~> 2.4.1'
  spec.add_dependency 'veto'
end
