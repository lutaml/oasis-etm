# frozen_string_literal: true

require_relative "../lib/oasis-etm"

# Require all support files
Dir[File.join(__dir__, "support", "**", "*.rb")].each do |f|
  require f
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require "nokogiri"
Lutaml::Model::Config.configure do |config|
  config.xml_adapter_type = :nokogiri
end

require "canon"
Canon::Config.configure do |config|
  config.xml.match.profile = :spec_friendly
  config.xml.diff.use_color = true
end
