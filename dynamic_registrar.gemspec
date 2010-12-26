# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dynamic_registrar/version"

Gem::Specification.new do |s|
  s.name        = "dynamic_registrar"
  s.version     = DynamicRegistrar::Version.inspect
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Justin Lynn (justinlynn)","3Crowd Technologies, Inc. (Sponsor)"]
  s.email       = ["ops@3crowd.com"]
  s.homepage    = "https://github.com/3Crowd/dynamic_registrar"
  s.summary     = %q{Registration for dynamic invocation}
  s.description = %q{Namespaced and versioned registration of callbacks for dynamic invocation by clients}

  s.rubyforge_project = "dynamic_registrar"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'yard', '~> 0.6.3'
  s.add_dependency 'cover_me', '~> 1.0.0.rc4'
  s.add_dependency 'parallel_tests', '~> 0.4.9'
  s.add_dependency 'ZenTest', '~> 4.4.2'
end
