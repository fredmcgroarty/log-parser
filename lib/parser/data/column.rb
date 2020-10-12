# frozen_string_literal: true

module Parser
  module Data
    class Column
      attr_reader :name, :table

      def initialize(table, name)
        @name = name.to_s
        @table = table
      end

      def position
        @position ||= table.columns.index(self)
      end

      def to_a
        @input
      end
    end
  end
end
