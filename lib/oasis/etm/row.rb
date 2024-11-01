require_relative "entry"

module Oasis
  module Etm
    class Row < Lutaml::Model::Serializable
      # Optional attributes
      attribute :rowsep, :integer, values: [0, 1]
      attribute :valign, :string, values: %w[top middle bottom]

      # Content
      attribute :entries, Entry, collection: true

      xml do
        root "row"

        map_attribute "rowsep", to: :rowsep
        map_attribute "valign", to: :valign
        map_element "entry", to: :entries
      end
    end
  end
end
