module Oasis
  module Etm
    class Table < Lutaml::Model::Serializable
      # Table attributes
      # colsep/rowsep accept both integer (0/1) and string ("yes"/"no") values.
      # The string form "yes"/"no" is a legacy SGML representation supported for
      # backward compatibility with older Exchange Table Model documents.
      attribute :frame, :string, values: %w[top bottom topbot all sides none]
      attribute :colsep, :string, values: %w[0 1 yes no]
      attribute :rowsep, :string, values: %w[0 1 yes no]
      attribute :pgwide, :string, values: %w[0 1 yes no]

      # Table content
      attribute :title, :string
      attribute :tgroups, Tgroup, collection: true

      xml do
        element "table"
        namespace Namespace
        ordered

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
