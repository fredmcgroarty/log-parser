# frozen_string_literal: true

RSpec.describe Parser::Data::Table do
  let :table do
    described_class.new('table name')
  end

  let(:ips_column) { Parser::Data::Column.new(table, 'ips') }
  let(:paths_column) { Parser::Data::Column.new(table, 'paths') }

  let :columns do
    [paths_column, ips_column]
  end

  describe '#add_column' do
    it 'receives an array as an arg and adds a column' do
      expect { table.add_column(%w[ips paths]) }.to change(table.columns, :count).by(2)
      expect { table.add_column(%w[timestamps]) }.to change(table.columns, :count).by(1)

      expect(table.columns.count).to eq 3
    end
  end

  describe '#add_row(input)' do
    it 'receives an array as an argument and adds a row' do
      table.columns.push(*columns)

      expect { table.add_row(%w[/path 1.2.3.4]) }.to change(table.rows, :count).by(1)

      two_d_input = [['/home', '1.2.3.4'], ['/products', '1.2.3.4']]
      expect { table.add_row(two_d_input) }.to change(table.rows, :count).by(2)

      expect(table.rows.count).to eq 3
      expect(table.rows.any? { |row| row.send(:input).empty? }).to eq false
    end
  end

  describe '#column_names' do
    it 'receives an array of column names' do
      table.columns.push(ips_column, paths_column)
      expect(table.column_names).to eq %w[ips paths]
    end
  end

  describe '#find_column(name)' do
    it 'finds & returns the column by its name' do
      table = described_class.new('table name')
      table.columns.push(*columns)

      expect(table.find_column('ips')).to eq ips_column
      expect(table.find_column('paths')).to eq paths_column
    end
  end

  describe '#to_a' do
    context 'when columns are defined' do
      before do
        table.columns.push(*columns)
      end

      it 'adds row if the length is correct' do
        expect(table.rows).to eq []

        path = '/home'
        ip = '127.0.0.1'
        table.add_row([path, ip])

        output = table.rows.collect(&:to_a)
        expect(output).to eq [[path, ip]]
      end
    end
  end
end
