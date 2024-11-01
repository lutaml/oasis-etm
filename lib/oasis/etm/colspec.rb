module Oasis
  module Etm
    class Colspec < Lutaml::Model::Serializable
      # Optional attributes
      attribute :colnum, :integer
      attribute :colname, :string
      attribute :colwidth, :string
      attribute :colsep, :integer, values: [0, 1]
      attribute :rowsep, :integer, values: [0, 1]
      attribute :align, :string, values: %w[left right center justify char]
      attribute :char, :string
      attribute :charoff, :string

      xml do
        root "colspec"

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
