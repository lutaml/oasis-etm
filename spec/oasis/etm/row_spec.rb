RSpec.describe Oasis::Etm::Row do
  let(:xml) do
    <<~XML
      <row rowsep="1" valign="middle">
        <entry>Cell 1</entry>
        <entry>Cell 2</entry>
        <entry>Cell 3</entry>
      </row>
    XML
  end

  describe ".from_xml" do
    subject(:row) { described_class.from_xml(xml) }

    it "parses attributes" do
      expect(row.rowsep).to eq(1)
      expect(row.valign).to eq("middle")
    end

    it "parses entries" do
      expect(row.entries.size).to eq(3)
      expect(row.entries.map(&:content)).to eq(["Cell 1", "Cell 2", "Cell 3"])
    end
  end

  describe "#to_xml" do
    subject(:row) do
      described_class.new(
        rowsep: 1,
        valign: "middle",
        entries: [
          Oasis::Etm::Entry.new(content: "Cell 1"),
          Oasis::Etm::Entry.new(content: "Cell 2"),
          Oasis::Etm::Entry.new(content: "Cell 3"),
        ],
      )
    end

    it "generates valid XML" do
      expect(row.to_xml).to be_analogous_with(xml)
    end
  end
end
