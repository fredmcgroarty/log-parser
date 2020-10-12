# frozen_string_literal: true

module Parser
  module Data
    lib_dir = File.dirname(__FILE__)
    require "#{lib_dir}/data/column"
    require "#{lib_dir}/data/row"
    require "#{lib_dir}/data/table"
  end
end
