# frozen_string_literal: true

module Parser
  require 'optparse'
  require 'resolv'
  require 'set'

  lib_dir = File.dirname(__FILE__)

  require "#{lib_dir}/parser/config"
  require "#{lib_dir}/parser/data"
  require "#{lib_dir}/parser/errors"
  require "#{lib_dir}/parser/log_file"
  require "#{lib_dir}/parser/queries"
  require "#{lib_dir}/parser/runner"

  class << self
    def run(args = ARGV)
      config = Config.new
      config.parse(args)

      runner = Runner.new(config)
      result = runner.perform

      array = result.each_with_object([]) do |(key, value), memo|
        memo << [key, value.size]
      end

      array.each do |row|
        p row.join(' ') + "#{' unique' if config.opts_unique} visits"
      end
    end
  end
end
