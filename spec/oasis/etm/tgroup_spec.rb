RSpec.describe Oasis::Etm::Tgroup do
  let(:xml) do
    <<~XML
      <tgroup cols="3" colsep="1" rowsep="1" align="center">
        <colspec colnum="1" colwidth="1*"/>
        <colspec colnum="2" colwidth="2*"/>
        <colspec colnum="3" colwidth="1*"/>
        <thead>
          <row>
            <entry>Header 1</entry>
            <entry>Header 2</entry>
            <entry>Header 3</entry>
          </row>
        </thead>
        <tbody>
          <row>
            <entry>Cell 1</entry>
            <entry>Cell 2</entry>
            <entry>Cell 3</entry>
          </row>
        </tbody>
      </tgroup>
    XML
  end

  describe ".from_xml" do
    subject(:tgroup) { described_class.from_xml(xml) }

    it "parses required attributes" do
      expect(tgroup.cols).to eq(3)
    end

    it "parses optional attributes" do
      expect(tgroup.colsep).to eq(1)
      expect(tgroup.rowsep).to eq(1)
      expect(tgroup.align).to eq("center")
    end

    it "parses colspecs" do
      expect(tgroup.colspecs.size).to eq(3)
      expect(tgroup.colspecs.first.colnum).to eq(1)
      expect(tgroup.colspecs.first.colwidth).to eq("1*")
    end

    it "parses thead" do
      expect(tgroup.thead).to be_a(Oasis::Etm::Thead)
      expect(tgroup.thead.rows.size).to eq(1)
    end

    it "parses tbody" do
      expect(tgroup.tbody).to be_a(Oasis::Etm::Tbody)
      expect(tgroup.tbody.rows.size).to eq(1)
    end
  end

  describe "#to_xml" do
    subject(:tgroup) do
      described_class.new(
        cols: 3,
        colsep: 1,
        rowsep: 1,
        align: "center",
        colspecs: [
          Oasis::Etm::Colspec.new(colnum: 1, colwidth: "1*"),
          Oasis::Etm::Colspec.new(colnum: 2, colwidth: "2*"),
          Oasis::Etm::Colspec.new(colnum: 3, colwidth: "1*"),
        ],
        thead: Oasis::Etm::Thead.new(
          rows: [
            Oasis::Etm::Row.new(
              entries: [
                Oasis::Etm::Entry.new(content: "Header 1"),
                Oasis::Etm::Entry.new(content: "Header 2"),
                Oasis::Etm::Entry.new(content: "Header 3"),
              ],
            ),
          ],
        ),
        tbody: Oasis::Etm::Tbody.new(
          rows: [
            Oasis::Etm::Row.new(
              entries: [
                Oasis::Etm::Entry.new(content: "Cell 1"),
                Oasis::Etm::Entry.new(content: "Cell 2"),
                Oasis::Etm::Entry.new(content: "Cell 3"),
              ],
            ),
          ],
        ),
      )
    end

    it "generates valid XML" do
      expect(tgroup.to_xml).to be_analogous_with(xml)
    end
  end
end
