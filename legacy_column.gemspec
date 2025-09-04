lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "legacy_column/version"

Gem::Specification.new do |spec|
  spec.name          = "legacy_column"
  spec.version       = LegacyColumn::VERSION
  spec.authors       = ["Aleksander Lopez Yazikov"]
  spec.email         = ["webodessa@gmail.com"]

  spec.summary       = %q{Warning for your legacy columns.}
  spec.description   = %q{A gem that will print a message if a developer is trying to use a column that is from a legacy system but has to stay there.}
  spec.homepage      = "https://github.com/logicalgroove/legacy_column"
  spec.license       = "MIT"

  spec.files         = Dir["{lib,spec}/**/*", "[A-Z]*", "init.rb"]
  spec.require_paths = ["lib"]

  spec.required_rubygems_version = ">= 1.3.4"

  spec.add_dependency "activesupport", [">= 5.2.0", "< 9.0"]
  spec.add_dependency "activerecord", [">= 5.2.0", "< 9.0"]
  spec.add_development_dependency "bundler", ">= 2.2.33"
  spec.add_development_dependency "rake", "~> 13.0.1"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "sqlite3", ">= 1.4.0"
end
