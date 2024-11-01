# spec/support/shared_examples/validation_examples.rb
RSpec.shared_examples "validates attributes" do |attributes|
  attributes.each do |attribute, valid_values|
    context "with #{attribute}" do
      it "accepts valid values" do
        valid_values.each do |value|
          expect {
            described_class.new(attribute => value)
          }.not_to raise_error
        end
      end

      it "rejects invalid values" do
        expect {
          described_class.new(attribute => "invalid")
        }.to raise_error(Lutaml::Model::ValidationError)
      end
    end
  end
end
