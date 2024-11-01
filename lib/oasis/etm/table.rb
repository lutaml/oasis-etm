require_relative "tgroup"

module Oasis
  module Etm
    class Table < Lutaml::Model::Serializable
      # Table attributes
      attribute :frame, :string, values: %w[top bottom topbot all sides none]
      attribute :colsep, :integer, values: [0, 1]
      attribute :rowsep, :integer, values: [0, 1]
      attribute :pgwide, :integer, values: [0, 1]

      # Table content
      attribute :title, :string
      attribute :tgroups, Tgroup, collection: true

      xml do
        root "table"

        # Frame mappings
        map_attribute "frame", to: :frame
        map_attribute "colsep", to: :colsep
        map_attribute "rowsep", to: :rowsep
        map_attribute "pgwide", to: :pgwide

        # Content mappings
        map_element "title", to: :title
        map_element "tgroup", to: :tgroups
      end
    end
  end
end
