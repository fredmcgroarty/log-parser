# frozen_string_literal: true

module Parser
  module Data
    class Row
      include Enumerable

      def initialize(table, input)
        @table = table
        @input = input

        raise Parser::Errors::InvalidRow, 'Invalid row data' unless valid?
      end

      def [](index)
        input[index]
      end

      def each
        input.each { |row| yield row }
      end

      def to_a
        input
      end

      private

      attr_reader :input, :table

      def valid?
        input.is_a?(Enumerable) && (input.length == table.column_names.length)
      end
    end
  end
end
