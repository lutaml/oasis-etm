module Oasis
  module Etm
    class Row < Lutaml::Model::Serializable
      # Optional attributes
      # rowsep accepts both integer (0/1) and string ("yes"/"no") values.
      # The string form "yes"/"no" is a legacy SGML representation supported for
      # backward compatibility with older Exchange Table Model documents.
      attribute :rowsep, :string, values: %w[0 1 yes no]
      attribute :valign, :string, values: %w[top middle bottom]

      # Content
      attribute :entries, Entry, collection: true

      xml do
        element "row"
        namespace Namespace

        map_attribute "rowsep", to: :rowsep
        map_attribute "valign", to: :valign
        map_element "entry", to: :entries
      end
    end
  end
end
