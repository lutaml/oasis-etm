module Oasis
  module Etm
    class Colspec < Lutaml::Model::Serializable
      # Optional attributes
      # colsep/rowsep accept both integer (0/1) and string ("yes"/"no") values.
      # The string form "yes"/"no" is a legacy SGML representation supported for
      # backward compatibility with older Exchange Table Model documents.
      attribute :colnum, :integer
      attribute :colname, :string
      attribute :colwidth, :string
      attribute :colsep, :string, values: %w[0 1 yes no]
      attribute :rowsep, :string, values: %w[0 1 yes no]
      attribute :align, :string, values: %w[left right center justify char]
      attribute :char, :string
      attribute :charoff, :string

      xml do
        element "colspec"
        namespace Namespace
        ordered

        map_attribute "colnum", to: :colnum
        map_attribute "colname", to: :colname
        map_attribute "colwidth", to: :colwidth
        map_attribute "colsep", to: :colsep
        map_attribute "rowsep", to: :rowsep
        map_attribute "align", to: :align
        map_attribute "char", to: :char
        map_attribute "charoff", to: :charoff
      end
    end
  end
end
