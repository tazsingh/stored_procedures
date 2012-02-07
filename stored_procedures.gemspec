# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "stored_procedures/version"

Gem::Specification.new do |s|
  s.name        = "stored_procedures"
  s.version     = StoredProcedures::VERSION
  s.authors     = ["Tasveer Singh", "Nick Hoffman"]
  s.email       = ["taz@zenapsis.com", "nick@deadorange.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "stored_procedures"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rails", ">= 3.0"

  s.add_development_dependency "mongo", ">= 1.5"
  s.add_development_dependency "rspec"
end
