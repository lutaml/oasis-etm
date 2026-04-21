# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```sh
bundle install                    # Install dependencies (uses lutaml-model from GitHub main)
bundle exec rspec                 # Run all specs
bundle exec rspec spec/oasis/etm/table_spec.rb  # Run a single spec file
bundle exec rspec spec/oasis/etm/table_spec.rb:30  # Run a single test by line number
bundle exec rubocop               # Lint
bundle exec rake                  # Run specs + rubocop (default task)
```

## Architecture

This gem implements the OASIS Exchange Table Model (TR 9503:1995) as Ruby objects using `lutaml-model` for XML serialization/deserialization.

**Core dependency chain:** All models inherit from `Lutaml::Model::Serializable` and share a common `Oasis::Etm::Namespace` definition (canonical URI: `http://docs.oasis-open.org/ns/oasis-exchange/table`, with `uri_aliases` for `urn:oasis:names:tc:xml:table` and the legacy FPI).

**Model hierarchy:** `Table` → `Tgroup` → (`Colspec`, `Thead` → `Row` → `Entry`, `Tbody` → `Row` → `Entry`). Each model declares its XML element, namespace, and attribute/element mappings via the `xml do` DSL block.

**Key model behaviors:**
- `colsep`, `rowsep`, `pgwide` attributes accept both integer (`0`/`1`) and legacy SGML string (`"yes"`/`"no"`) values — typed as `:string` with `values: %w[0 1 yes no]`
- `Entry` uses `mixed_content` and `collection: true` on its `content` attribute for mixed XML content handling
- `Table` and `Tgroup` use `ordered` to preserve child element ordering
- The `Namespace` class (subclass of `Lutaml::Xml::Namespace`) defines `uri_aliases` so all three namespace variants parse correctly; serialization always uses the canonical URI

**Spec structure:**
- `spec/oasis/etm/` — unit specs per model (table, entry, tgroup, etc.)
- `spec/oasis/etm_spec.rb` — round-trip tests using XML fixture files from `spec/fixtures/{native,isosts,niso-jats}/`
- Round-trip tests use the Canon gem (`be_analogous_with` matcher) with `spec_friendly` profile for XML comparison
- Some fixtures contain foreign elements (`<bold>`, `<para>`, `<xref>`) removed via Nokogiri before parsing
- ISOSTS fixtures normalize FPI namespace to URN before comparison (Canon requirement)
