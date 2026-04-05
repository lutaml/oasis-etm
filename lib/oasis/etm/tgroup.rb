module Oasis
  module Etm
    class Tgroup < Lutaml::Model::Serializable
      # Required attributes
      attribute :cols, :integer

      # Optional attributes
      # colsep/rowsep accept both integer (0/1) and string ("yes"/"no") values.
      # The string form "yes"/"no" is a legacy SGML representation supported for
      # backward compatibility with older Exchange Table Model documents.
      attribute :colsep, :string, values: %w[0 1 yes no]
      attribute :rowsep, :string, values: %w[0 1 yes no]
      attribute :align, :string, values: %w[left right center justify char]

      # Content
      attribute :colspecs, Colspec, collection: true
      attribute :thead, Thead
      attribute :tbody, Tbody

      xml do
        element "tgroup"
        namespace Namespace
        ordered

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
