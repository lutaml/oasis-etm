RSpec.describe Oasis::Etm::Tbody do
  let(:xml) do
    <<~XML
      <tbody valign="top">
        <row>
          <entry>Cell 1</entry>
          <entry>Cell 2</entry>
          <entry>Cell 3</entry>
        </row>
      </tbody>
    XML
  end

  describe ".from_xml" do
    subject(:tbody) { described_class.from_xml(xml) }

    it "parses valign attribute" do
      expect(tbody.valign).to eq("top")
    end

    it "parses rows" do
      expect(tbody.rows.size).to eq(1)
      expect(tbody.rows.first.entries.size).to eq(3)
      expect(tbody.rows.first.entries.first.content).to eq("Cell 1")
    end
  end

  describe "#to_xml" do
    subject(:tbody) do
      described_class.new(
        valign: "top",
        rows: [
          Oasis::Etm::Row.new(
            entries: [
              Oasis::Etm::Entry.new(content: "Cell 1"),
              Oasis::Etm::Entry.new(content: "Cell 2"),
              Oasis::Etm::Entry.new(content: "Cell 3"),
            ],
          ),
        ],
      )
    end

    it "generates valid XML" do
      expect(tbody.to_xml).to be_analogous_with(xml)
    end
  end
end
