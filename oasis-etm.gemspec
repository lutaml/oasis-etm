# frozen_string_literal: true

require_relative "lib/oasis/etm/version"

Gem::Specification.new do |spec|
  spec.name = "oasis-etm"
  spec.version = Oasis::Etm::VERSION
  spec.authors = ["Ribose Inc."]
  spec.email = ["open.source@ribose.com"]

  spec.summary = "Library for OASIS Exchange Table Model"
  spec.description = <<~DESCRIPTION
    Library for manipulation of OASIS Exchange Table Model XML.
  DESCRIPTION

  spec.homepage = "https://github.com/lutaml/oasis-etm"
  spec.license = "BSD-2-Clause"

  spec.bindir = "exe"
  spec.require_paths = ["lib"]
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the
  # RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|features)/})
    end
  end
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }

  spec.add_dependency "lutaml-model"
  spec.metadata["rubygems_mfa_required"] = "true"
end
