# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-regexpload"
  spec.version       = "0.0.0"
  spec.authors       = ["TakahiroHayashida"]
  spec.email         = []
  spec.summary       = %q{Random data generate and loading plugin for fluent}
  spec.description   = %q{oops...}
  spec.homepage      = ""
  spec.license       = ""

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  gem.add_development_dependency "fluentd"
  spec.add_development_dependency "rake"
  gem.add_runtime_dependency "fluentd"
end
