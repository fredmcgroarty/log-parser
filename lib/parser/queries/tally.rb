# frozen_string_literal: true

module Parser
  module Queries
    class Tally
      def initialize(table)
        @table = table
      end

      def perform(*args, enum_type: Array)
        args.map!(&:to_s)
        counter_col = table.find_column(args[0])
        counted_col = table.find_column(args[1])

        table.rows.each_with_object({}) do |row, memo|
          key = row[counter_col.position]
          memo[key] ||= enum_type.new
          memo[key] << row[counted_col.position]
        end
      end

      private

      attr_reader :table
    end
  end
end
