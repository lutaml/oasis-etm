RSpec.describe Oasis::Etm::Table do
  let(:xml) do
    <<~XML
      <table frame="all" colsep="1" rowsep="1">
        <title>Sample Table</title>
        <tgroup cols="3">
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
      </table>
    XML
  end

  describe ".from_xml" do
    subject(:table) { described_class.from_xml(xml) }

    it "parses table attributes" do
      expect(table.frame).to eq("all")
      expect(table.colsep).to eq(1)
      expect(table.rowsep).to eq(1)
    end

    it "parses title" do
      expect(table.title).to eq("Sample Table")
    end

    it "parses tgroup" do
      expect(table.tgroups.size).to eq(1)
      expect(table.tgroups.first.cols).to eq(3)
    end
  end

  describe "#to_xml" do
    subject(:table) do
      described_class.new(
        frame: "all",
        colsep: 1,
        rowsep: 1,
        title: "Sample Table",
        tgroups: [
          Oasis::Etm::Tgroup.new(
            cols: 3,
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
          ),
        ],
      )
    end

    it "generates valid XML" do
      expect(table.to_xml).to be_analogous_with(xml)
    end
  end
end
