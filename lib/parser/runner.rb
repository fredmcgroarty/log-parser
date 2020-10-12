# frozen_string_literal: true

module Parser
  class Runner
    def initialize(config)
      @config = config
      @log_file = LogFile.parse(config.opts_fpath)
    end

    def perform
      @table = Data::Table.new(
        config.opts_fpath,
        columns: config.opts_column_names, rows: log_file.split_lines
      )
      perform_tally_query if config.opts_tally
    end

    private

    attr_reader :config, :log_file, :table

    def perform_tally_query
      query = Queries::Tally.new(table)
      return query.perform(*config.opts_tally_order, enum_type: Set) if config.opts_unique

      query.perform(*config.opts_tally_order)
    end
  end
end
