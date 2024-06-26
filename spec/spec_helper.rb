# frozen_string_literal: true

require 'rspec-html-matchers'
require 'support/fixture_database'
require 'rack'
require 'pagy'
require 'pagy/extras/govuk'
Pagy::GovukExtra.add_default_i18n_load_path

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
