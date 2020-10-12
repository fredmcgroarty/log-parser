# frozen_string_literal: true

RSpec.describe Parser::Data::Row do
  let(:table) { Parser::Data::Table.new('table name', columns: %w[foo bar]) }

  describe '.initialize' do
    it 'requires a table and input' do
      expect { described_class.new(table) }.to raise_error(ArgumentError)
      expect { described_class.new }.to raise_error(ArgumentError)

      expect(described_class.new(table, %w[foo bar])).to be_a described_class
    end

    it 'requires the input to be an array with eq length to table columns length' do
      table = Parser::Data::Table.new('table name', columns: %i[1 2 3])

      expect { described_class.new(table, 'leomns') }.to raise_error(Parser::Errors::InvalidRow)

      expect { described_class.new(table, %i[1]) }.to raise_error(Parser::Errors::InvalidRow)
      expect { described_class.new(table, %i[1 2]) }.to raise_error(Parser::Errors::InvalidRow)

      expect(described_class.new(table, %i[1 2 3])).to be_a(described_class)
    end
  end

  describe '[](index)' do
    it 'returns the given index from the input array' do
      row = described_class.new(table, %w[a b])

      expect(row[0]).to eq 'a'
      expect(row[1]).to eq 'b'
      expect(row[2]).to be_nil
    end
  end

  describe '#to_a' do
    it 'returns the row input' do
      row = described_class.new(table, %w[a b])
      expect(row.to_a).to eq %w[a b]
    end
  end
end
