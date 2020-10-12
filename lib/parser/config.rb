# frozen_string_literal: true

module Parser
  class Config
    VERSION = '1.0.0'

    attr_reader :options, :option_parser

    def initialize
      @options = Options.new
      @option_parser = OptionParser.new do |parser|
        options.define_options(parser)
      end
    end

    def parse(args)
      raise Errors::NoFilePathGiven, 'you must specify a path to a file' if args.empty?

      options.fpath = args.shift

      args << '-p' if args.empty?
      option_parser.parse!(args)
    end

    def method_missing(method, *args, &block)
      if method.to_s =~ /opts_(.*)/
        options.send(method.to_s.delete_prefix('opts_'), *args, &block)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s.start_with?('opts_') || super
    end

    class Options
      attr_accessor :column_names,
                    :fpath,
                    :tally,
                    :unique
      attr_writer :tally_order

      def initialize
        self.column_names = []
        self.fpath = nil
        self.tally = false
        self.unique = false
      end

      def define_options(parser)
        parser.banner = 'Usage: parser.rb [options]'
        parser.separator ''
        parser.separator 'Specific options:'

        perform_common_options(parser)
        perform_ip_visits(parser)
        perform_page_visits(parser)
      end

      def tally_order
        @tally_order ||= column_names
      end

      private

      def perform_common_options(parser)
        parser.separator ''
        parser.separator 'Common options:'
        parser.on_tail('-h', '--help', 'Show this message') do
          p parser
          exit
        end
        parser.on_tail('--version', 'Show version') do
          p VERSION
          exit
        end
      end

      def perform_page_visits(parser)
        parser.on('-p', '--page-visits [UNIQUE]', 'show tally for page visits.', "add 'u' to make unique") do |opt|
          self.column_names = %i[paths ips]
          self.tally = true
          self.unique = true if opt == 'u'
        end
      end

      def perform_ip_visits(parser)
        parser.on('-i', '--ip-visits [UNIQUE]', 'show tally for ip visits.', "add 'u' to make unique") do |opt|
          self.column_names = %i[paths ips]
          self.tally = true
          self.tally_order = %i[ips paths]
          self.unique = true if opt == 'u'
        end
      end
    end
  end
end
