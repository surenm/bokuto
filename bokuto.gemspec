# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/bokuto/version'

Gem::Specification.new do |spec|
  spec.name          = "bokuto"
  spec.version       = Capistrano::Bokuto::VERSION
  spec.authors       = ["Hubert Liu", "Surendran Mahendran"]
  spec.email         = ["hubert.c.liu@gmail.com", "surenspost@gmail.com"]
  spec.description   = %q{Heroku like deployments for AWS Opsworks Rails services}
  spec.summary       = %q{Providing simple tasks analagous to deploy Rails applications to AWS OpsWorks using capistrano 3}
  spec.homepage      = "https://github.com/surenm/bokuto"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "aws"
end
