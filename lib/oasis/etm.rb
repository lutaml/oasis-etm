# frozen_string_literal: true

require "lutaml/model"

module Oasis
  module Etm
    class Error < StandardError; end

    autoload :Colspec, "oasis/etm/colspec"
    autoload :Entry, "oasis/etm/entry"
    autoload :Namespace, "oasis/etm/namespace"
    autoload :Row, "oasis/etm/row"
    autoload :Table, "oasis/etm/table"
    autoload :Tbody, "oasis/etm/tbody"
    autoload :Colspec, "oasis/etm/tcol"
    autoload :Tgroup, "oasis/etm/tgroup"
    autoload :Thead, "oasis/etm/thead"
    autoload :VERSION, "oasis/etm/version"
  end
end
