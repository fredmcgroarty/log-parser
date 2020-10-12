# frozen_string_literal: true

RSpec.describe Parser::Data::Column do
  let(:table) { Parser::Data::Table.new('balls') }

  describe 'initialize' do
    it 'requires a name & table' do
      column = described_class.new(table, 'col name')

      expect(column.name).to eq('col name')
      expect(column.table).to eq(table)

      expect { described_class.new }.to raise_error ArgumentError
    end
  end

  describe '#position' do
    it 'returns the index of the column in the table' do
      column1 = described_class.new(table, 'col1')
      column2 = described_class.new(table, 'col2')

      table.columns.push(column1, column2)

      expect(column1.position).to eq(0)
      expect(column2.position).to eq(1)
    end
  end
end
