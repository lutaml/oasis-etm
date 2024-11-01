RSpec.describe Oasis::Etm::Thead do
  let(:xml) do
    <<~XML
      <thead valign="middle">
        <row>
          <entry>Header 1</entry>
          <entry>Header 2</entry>
          <entry>Header 3</entry>
        </row>
      </thead>
    XML
  end

  describe ".from_xml" do
    subject(:thead) { described_class.from_xml(xml) }

    it "parses valign attribute" do
      expect(thead.valign).to eq("middle")
    end

    it "parses rows" do
      expect(thead.rows.size).to eq(1)
      expect(thead.rows.first.entries.size).to eq(3)
      expect(thead.rows.first.entries.first.content).to eq("Header 1")
    end
  end

  describe "#to_xml" do
    subject(:thead) do
      described_class.new(
        valign: "middle",
        rows: [
          Oasis::Etm::Row.new(
            entries: [
              Oasis::Etm::Entry.new(content: "Header 1"),
              Oasis::Etm::Entry.new(content: "Header 2"),
              Oasis::Etm::Entry.new(content: "Header 3"),
            ],
          ),
        ],
      )
    end

    it "generates valid XML" do
      expect(thead.to_xml).to be_equivalent_to(xml)
    end
  end
end
