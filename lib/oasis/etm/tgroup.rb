require_relative "colspec"
require_relative "thead"
require_relative "tbody"

module Oasis
  module Etm
    class Tgroup < Lutaml::Model::Serializable
      # Required attributes
      attribute :cols, :integer

      # Optional attributes
      attribute :colsep, :integer, values: [0, 1]
      attribute :rowsep, :integer, values: [0, 1]
      attribute :align, :string, values: %w[left right center justify char]

      # Content
      attribute :colspecs, Colspec, collection: true
      attribute :thead, Thead
      attribute :tbody, Tbody

      xml do
        root "tgroup"

        # Attribute mappings
        map_attribute "cols", to: :cols
        map_attribute "colsep", to: :colsep
        map_attribute "rowsep", to: :rowsep
        map_attribute "align", to: :align

        # Content mappings
        map_element "colspec", to: :colspecs
        map_element "thead", to: :thead
        map_element "tbody", to: :tbody
      end
    end
  end
end
