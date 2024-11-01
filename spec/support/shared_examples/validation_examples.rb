# spec/support/shared_examples/validation_examples.rb
RSpec.shared_examples "validates attributes" do |attributes|
  attributes.each do |attribute, valid_values|
    context "with #{attribute}" do
      it "accepts valid values" do
        valid_values.each do |value|
          expect do
            described_class.new(attribute => value)
          end.not_to raise_error
        end
      end

      it "rejects invalid values" do
        expect do
          described_class.new(attribute => "invalid")
        end.to raise_error(Lutaml::Model::ValidationError)
      end
    end
  end
end
