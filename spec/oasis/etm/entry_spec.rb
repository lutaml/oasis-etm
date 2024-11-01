# spec/oasis/etm/entry_spec.rb
RSpec.describe Oasis::Etm::Entry do
  let(:xml) do
    <<~XML
      <entry
        colname="col1"
        namest="col1"
        nameend="col2"
        morerows="1"
        colsep="1"
        rowsep="1"
        align="center"
        char="."
        charoff="50"
        valign="middle">Cell content</entry>
    XML
  end

  describe ".from_xml" do
    subject(:entry) { described_class.from_xml(xml) }

    it "parses attributes" do
      expect(entry.colname).to eq("col1")
      expect(entry.namest).to eq("col1")
      expect(entry.nameend).to eq("col2")
      expect(entry.morerows).to eq(1)
      expect(entry.colsep).to eq(1)
      expect(entry.rowsep).to eq(1)
      expect(entry.align).to eq("center")
      expect(entry.char).to eq(".")
      expect(entry.charoff).to eq("50")
      expect(entry.valign).to eq("middle")
    end

    it "parses content" do
      expect(entry.content).to eq("Cell content")
    end
  end

  describe "#to_xml" do
    subject(:entry) do
      described_class.new(
        colname: "col1",
        namest: "col1",
        nameend: "col2",
        morerows: 1,
        colsep: 1,
        rowsep: 1,
        align: "center",
        char: ".",
        charoff: "50",
        valign: "middle",
        content: "Cell content",
      )
    end

    it "generates valid XML" do
      expect(entry.to_xml).to be_analogous_with(xml)
    end
  end

  context "with validation" do
    it "validates align values" do
      entry = described_class.new(align: "invalid")
      errors = entry.validate
      expect(errors).to match_array(
        have_attributes(
          message: /align is `invalid`, must be one of the following \[left, right, center, justify, char\]/,
        ),
      )
    end

    it "validates valign values" do
      entry = described_class.new(valign: "invalid")
      errors = entry.validate
      expect(errors).to match_array(
        have_attributes(
          message: /valign is `invalid`, must be one of the following \[top, middle, bottom\]/,
        ),
      )
    end

    it "validates colsep values" do
      entry = described_class.new(colsep: 2)
      errors = entry.validate
      expect(errors).to match_array(
        have_attributes(
          message: /colsep is `2`, must be one of the following \[0, 1\]/,
        ),
      )
    end

    it "validates rowsep values" do
      entry = described_class.new(rowsep: 2)
      errors = entry.validate
      expect(errors).to match_array(
        have_attributes(
          message: /rowsep is `2`, must be one of the following \[0, 1\]/,
        ),
      )
    end
  end
end
