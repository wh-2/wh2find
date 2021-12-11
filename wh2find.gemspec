$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "wh2find/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "wh2find"
  spec.version     = Wh2find::VERSION
  spec.authors     = ["Pablo Cha"]
  spec.email       = ["pabloc@fulljaus.com"]
  spec.homepage    = "https://github.com/wh-2/wh2find"
  spec.summary     = "A customizable search engine."
  spec.description = "This search engine was thinked to the where2-watch project, but developed customizable to anyone."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.pkg.github.com/wh-2"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.3", ">= 6.0.3.4"
  spec.add_dependency "mongoid", "~> 7.2"
  spec.add_dependency "influxdb-rails", "~> 1.0"
  spec.add_dependency "when2stop"
  spec.add_dependency "newrelic_rpm"
end
