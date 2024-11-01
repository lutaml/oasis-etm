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
            parsed = Oasis::Etm::Table.from_xml(xml_string)
            generated = parsed.to_xml(
              pretty: true,
              declaration: true,
              encoding: "utf-8",
            )

            cleaned_xml_string = xml_string
              .gsub(/^<\?xml.*\n/, "")

            expect(generated).to be_analogous_with(cleaned_xml_string)
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
            parsed = Oasis::Etm::Table.from_xml(xml_string)
            generated = parsed.to_xml(
              pretty: true,
              declaration: true,
              encoding: "utf-8",
            )

            cleaned_xml_string = xml_string
              .gsub(/^<\?xml.*\n/, "")

            expect(generated).to be_analogous_with(cleaned_xml_string)
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
            parsed = Oasis::Etm::Table.from_xml(xml_string)
            generated = parsed.to_xml(
              pretty: true,
              declaration: true,
              encoding: "utf-8",
            )

            cleaned_xml_string = xml_string
              .gsub(/^<\?xml.*\n/, "")

            expect(generated).to be_analogous_with(cleaned_xml_string)
          end
        end
      end
    end
  end
end
