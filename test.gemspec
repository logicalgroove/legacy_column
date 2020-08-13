
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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = spec.homepage
    spec.metadata["changelog_uri"] = "https://github.com/logicalgroove/legacy_column/blob/master/README.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files        = Dir["{lib,spec}/**/*", "[A-Z]*", "init.rb"]
  spec.require_paths = ["lib"]

  spec.required_rubygems_version = ">= 1.3.4"

  spec.add_dependency "activesupport", [">= 4.0.0"]
  spec.add_dependency "activerecord", [">= 4.0.0"]
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "sqlite3", [">= 1.3.6"]
end
