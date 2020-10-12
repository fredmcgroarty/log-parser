# frozen_string_literal: true

describe Parser::Queries::Tally do
  let :table do
    table = Parser::Data::Table.new('logs')
    table.add_column(%w[paths ips])

    rows = [
      ['/contact', '1'],
      ['/contact', '2'],
      ['/home', '1'],
      ['/home', '1'],
      ['/products', '2']
    ]
    table.add_row(rows)

    table
  end

  describe 'tally' do
    let(:tally) { described_class.new(table) }

    context 'when quantifying paths to ips' do
      it 'returns a hash of arrays' do
        output = {
          '1' => ['/contact', '/home', '/home'],
          '2' => ['/contact', '/products']
        }

        expect(tally.perform(:ips, :paths)).to eq(output)
      end
    end

    context 'when quantifying ips to paths' do
      it 'returns a hash of arrays' do
        output = {
          '/products' => ['2'],
          '/contact' => %w[1 2],
          '/home' => %w[1 1]
        }

        expect(tally.perform(:paths, :ips)).to eq(output)
      end

      it 'receives different array types as an arg' do
        output = {
          '/products' => Set.new(%w[2]),
          '/contact' => Set.new(%w[1 2]),
          '/home' => Set.new(%w[1])
        }

        expect(tally.perform(:paths, :ips, enum_type: Set)).to eq(output)
      end
    end
  end
end
