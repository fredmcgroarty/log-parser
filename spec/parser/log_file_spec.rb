# frozen_string_literal: true

RSpec.describe(Parser::LogFile) do
  def valid_entry(ip: '1.2.3.4', path: '/foo')
    Parser::LogEntry.new(ip: ip, path: path)
  end

  describe '.parse' do
    def file_path(file_type = 'normal')
      "spec/fixtures/#{file_type}.log"
    end

    it 'raises an error if the file isnt found' do
      expect { described_class.parse(file_path('missing')) }.to(raise_error(Errno::ENOENT))
    end

    it 'returns a new instance of the class' do
      log_file = described_class.parse(file_path)
      expect(log_file).to(be_a(Parser::LogFile))
    end

    it 'parses every line in the log' do
      file = described_class.parse(file_path)
      expect(file.lines.length).to(eq(20))

      file = described_class.parse(file_path('short'))
      expect(file.lines.length).to(eq(5))

      file = described_class.parse(file_path('empty'))
      expect(file.lines.length).to(be_zero)
    end
  end
end
