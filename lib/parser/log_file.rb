# frozen_string_literal: true

module Parser
  class LogFile
    attr_reader :lines

    def self.parse(filename)
      lines = ::File.readlines(filename)
      new(lines)
    end

    def initialize(lines)
      @lines = lines
    end

    def split_lines(delimeter = ' ')
      @lines.map! do |line|
        line.split(delimeter)
      end
    end
  end
end
