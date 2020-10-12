# frozen_string_literal: true

module Parser
  module Data
    class Table
      attr_reader :columns,
                  :name,
                  :rows

      def initialize(name, columns: [], rows: [])
        @name = name

        @columns = []
        add_column(columns) if columns.any?

        @rows = []
        add_row(rows) if rows.any?
      end

      def add_column(cols)
        cols.each { |col| columns << Column.new(self, col) }
      end

      def add_row(inputs)
        if !inputs[0].is_a?(Enumerable)
          rows << Row.new(self, inputs)
        else
          inputs.each do |input|
            rows << Row.new(self, input)
          end
        end
      end

      def column_names
        columns.collect(&:name)
      end

      def find_column(name)
        columns.find do |column|
          column.name == name
        end
      end
    end
  end
end
