# frozen_string_literal: true

require "pathname"

RSpec.describe Oasis::Etm do
  fixtures_dir = Pathname.new(__dir__).join("../fixtures")

  describe "XML round-trip conversion" do
    describe "native XML" do
      xml_files = Dir[fixtures_dir.join("native", "*.xml")]

      xml_files.each do |file_path|
        context "with file #{Pathname.new(file_path).relative_path_from(fixtures_dir)}" do
          let(:xml_string) { File.read(file_path) }

          it "performs lossless round-trip conversion" do
            xml_content = xml_string.dup

            # Remove <para> elements which are foreign elements not supported by the model
            doc = Nokogiri::XML(xml_content)
            doc.xpath("//para").remove
            xml_content = doc.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::AS_XML)

            parsed = Oasis::Etm::Table.from_xml(xml_content)
            generated = parsed.to_xml(
              pretty: true,
              declaration: true,
              encoding: "utf-8",
            )

            # Model always adds xmlns to elements, so we need to add it to input for comparison
            # Add xmlns="" to title since model outputs title with empty namespace
            normalized_xml = xml_content
              .gsub("<table", '<table xmlns="http://docs.oasis-open.org/ns/oasis-exchange/table"')
              .gsub("<title>", '<title xmlns="">')

            expect(generated).to be_analogous_with(normalized_xml)
          end
        end
      end
    end

    describe "namespaced XML (ISOSTS)" do
      xml_files = Dir[fixtures_dir.join("isosts", "*.xml")]

      xml_files.each do |file_path|
        context "with file #{Pathname.new(file_path).relative_path_from(fixtures_dir)}" do
          let(:xml_string) { File.read(file_path) }

          it "performs lossless round-trip conversion" do
            xml_content = xml_string.dup

            # Normalize FPI namespace URI to URN for Canon compatibility
            xml_content = xml_content.gsub(
              'xmlns:oasis="-//OASIS//DTD XML Exchange Table Model 19990315//EN"',
              'xmlns:oasis="urn:oasis:names:tc:xml:table"',
            )

            # Remove <bold> elements which are foreign elements not supported by the model
            doc = Nokogiri::XML(xml_content)
            doc.xpath("//bold").remove
            xml_content = doc.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::AS_XML)

            parsed = Oasis::Etm::Table.from_xml(xml_content)
            generated = parsed.to_xml(
              prefix: true,
              pretty: true,
              declaration: true,
              encoding: "utf-8",
            )

            expect(generated).to be_analogous_with(xml_content)
          end
        end
      end
    end

    describe "namespaced XML (NISO JATS)" do
      xml_files = Dir[fixtures_dir.join("niso-jats", "*.xml")]

      xml_files.each do |file_path|
        context "with file #{Pathname.new(file_path).relative_path_from(fixtures_dir)}" do
          let(:xml_string) { File.read(file_path) }

          it "performs lossless round-trip conversion" do
            xml_content = xml_string.dup

            if file_path.include?("niso-jats-table-wrap.xml")
              # Remove <xref> elements which are foreign elements not supported by the model
              doc = Nokogiri::XML(xml_content)
              doc.xpath("//xref").remove
              xml_content = doc.to_xml(save_with: Nokogiri::XML::Node::SaveOptions::AS_XML)
            end

            parsed = Oasis::Etm::Table.from_xml(xml_content)
            generated = parsed.to_xml(
              prefix: true,
              pretty: true,
              declaration: true,
              encoding: "utf-8",
            )

            expect(generated).to be_analogous_with(xml_content)
          end
        end
      end
    end
  end
end
