RSpec.describe Oasis::Etm::Colspec do
  let(:xml) do
    <<~XML
      <colspec
        colnum="1"
        colname="col1"
        colwidth="1*"
        colsep="1"
        rowsep="1"
        align="center"
        char="."
        charoff="50"/>
    XML
  end

  describe ".from_xml" do
    subject(:colspec) { described_class.from_xml(xml) }

    it "parses all attributes" do
      expect(colspec.colnum).to eq(1)
      expect(colspec.colname).to eq("col1")
      expect(colspec.colwidth).to eq("1*")
      expect(colspec.colsep).to eq(1)
      expect(colspec.rowsep).to eq(1)
      expect(colspec.align).to eq("center")
      expect(colspec.char).to eq(".")
      expect(colspec.charoff).to eq("50")
    end
  end

  describe "#to_xml" do
    subject(:colspec) do
      described_class.new(
        colnum: 1,
        colname: "col1",
        colwidth: "1*",
        colsep: 1,
        rowsep: 1,
        align: "center",
        char: ".",
        charoff: "50",
      )
    end

    it "generates valid XML" do
      expect(colspec.to_xml).to be_equivalent_to(xml)
    end
  end
end
