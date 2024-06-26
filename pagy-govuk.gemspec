# frozen_string_literal: true

require_relative 'lib/pagy/govuk/version'

Gem::Specification.new do |spec|
  spec.name = 'pagy-govuk'
  spec.version = Pagy::Govuk::VERSION
  spec.authors = ['Russell Garner']
  spec.email = ['rgarner@zephyros-systems.co.uk']

  spec.summary = 'GOV.UK pagination styles for Pagy'
  spec.description = 'A Pagy Extra that renders GOV.UK pagination'
  spec.homepage = 'https://github.com/rgarner/pagy-govuk'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rgarner/pagy-govuk'
  spec.metadata['changelog_uri'] = 'https://github.com/rgarner/pagy-govuk/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'pagy', '~> 8.5'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end
