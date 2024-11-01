module Oasis
  module Etm
    class Entry < Lutaml::Model::Serializable
      # Optional attributes
      attribute :colname, :string
      attribute :namest, :string
      attribute :nameend, :string
      attribute :morerows, :integer
      attribute :colsep, :integer, values: [0, 1]
      attribute :rowsep, :integer, values: [0, 1]
      attribute :align, :string, values: %w[left right center justify char]
      attribute :char, :string
      attribute :charoff, :string
      attribute :valign, :string, values: %w[top middle bottom]

      # Content
      attribute :content, :string

      xml do
        root "entry"

        # Attribute mappings
        map_attribute "colname", to: :colname
        map_attribute "namest", to: :namest
        map_attribute "nameend", to: :nameend
        map_attribute "morerows", to: :morerows
        map_attribute "colsep", to: :colsep
        map_attribute "rowsep", to: :rowsep
        map_attribute "align", to: :align
        map_attribute "char", to: :char
        map_attribute "charoff", to: :charoff
        map_attribute "valign", to: :valign

        # Content mapping
        map_content to: :content
      end
    end
  end
end
