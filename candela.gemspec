# frozen_string_literal: true

require_relative "lib/candela/version"

Gem::Specification.new do |spec|
  spec.name = "candela"
  spec.version = Candela::VERSION
  spec.authors = ["Chris Petersen"]
  spec.email = ["chris@petersen.io"]

  spec.summary = "Ruby bindings for the Candle machine learning framework"
  spec.description = "Candela provides Ruby bindings for the Candle machine learning framework using Rust"
  spec.homepage = "https://github.com/cpetersen/candela"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/cpetersen/candela"
  spec.metadata["changelog_uri"] = "https://github.com/cpetersen/candela/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Native extension
  spec.extensions = ["ext/candela/extconf.rb"]
  
  # Include the extension files
  spec.files += Dir.glob("ext/**/*")
  
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
