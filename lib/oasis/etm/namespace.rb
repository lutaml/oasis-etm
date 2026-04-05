module Oasis
  module Etm
    class Namespace < Lutaml::Xml::Namespace
      uri "http://docs.oasis-open.org/ns/oasis-exchange/table"
      uri_aliases "urn:oasis:names:tc:xml:table",
                  "-//OASIS//DTD XML Exchange Table Model 19990315//EN"
      prefix_default "oasis"
    end
  end
end
