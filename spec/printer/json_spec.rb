require_relative '../../src/printer/json'

RSpec.describe SimpleNomics::Printer::JSON do
  subject { described_class.print(data, filters: filters) }

  let(:data) { { 'foo' => '1', 'bar' => 2, 'baz' => 3 } }
  let(:filters) { ['foo', 'baz'] }
  let(:result) do
    <<EOT
{
  "foo": "1",
  "baz": 3
}
EOT
  end

  it { is_expected.to eq(result) }
end
