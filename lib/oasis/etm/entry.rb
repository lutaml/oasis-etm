module Oasis
  module Etm
    class Entry < Lutaml::Model::Serializable
      # Optional attributes
      # colsep/rowsep accept both integer (0/1) and string ("yes"/"no") values.
      # The string form "yes"/"no" is a legacy SGML representation supported for
      # backward compatibility with older Exchange Table Model documents.
      attribute :colname, :string
      attribute :namest, :string
      attribute :nameend, :string
      attribute :morerows, :integer
      attribute :colsep, :string, values: %w[0 1 yes no]
      attribute :rowsep, :string, values: %w[0 1 yes no]
      attribute :align, :string, values: %w[left right center justify char]
      attribute :char, :string
      attribute :charoff, :string
      attribute :valign, :string, values: %w[top middle bottom]

      # Content
      attribute :content, :string, raw: true, collection: true

      xml do
        element "entry"
        namespace Namespace
        mixed_content

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
