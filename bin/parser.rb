#!/usr/bin/env ruby

# frozen_string_literal: true

require 'benchmark'
require_relative('../lib/parser')

Benchmark.bmbm do |results|
  results.report { Parser.run(ARGV.dup) if $PROGRAM_NAME == __FILE__ }
end
