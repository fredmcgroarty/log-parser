# frozen_string_literal: true

require_relative('../bin/parser')

describe Parser do
  describe 'run' do
    subject(:run) { Parser.run }
    def file_path(file_type = 'short')
      "spec/fixtures/#{file_type}.log"
    end

    it 'raises an error when no file is specified' do
      stub_const('ARGV', [])
      expect { run }.to raise_error(described_class::Errors::NoFilePathGiven, 'you must specify a path to a file')
    end

    it 'raises an error given a file that does not exist' do
      stub_const('ARGV', [file_path('missing')])
      expect { run }.to(raise_error(Errno::ENOENT))
    end

    context 'given a file that exists' do
      before(:all) do
        # let's not pollute rspec output, silence stdout.
        $stdout = File.open(File::NULL, 'w')
      end

      it 'returns page visits array if no additional arguments are passed' do
        stub_const('ARGV', [file_path])
        expected_output = [['/contact/', 2], ['/products/1', 2], ['/products/2', 1]]

        expect(run).to(eq(expected_output))
      end

      it 'returns the desired array when the page visits args are passed' do
        expected_output = [['/contact/', 2], ['/products/1', 2], ['/products/2', 1]]

        stub_const('ARGV', [file_path, '--page-visits'])
        expect(Parser.run).to(eq(expected_output))

        stub_const('ARGV', [file_path, '-p'])
        expect(Parser.run).to(eq(expected_output))
      end

      it 'returns the desired array when the unique page visits args are passed' do
        expected_output = [['/contact/', 2], ['/products/1', 1], ['/products/2', 1]]

        stub_const('ARGV', [file_path, '--page-visits=u'])
        expect(Parser.run).to(eq(expected_output))

        stub_const('ARGV', [file_path, '-pu'])
        expect(Parser.run).to(eq(expected_output))
      end

      it 'formats the output' do
        stub_const('ARGV', [file_path, '-p'])

        expect { Parser.run }.to output(%r{/contact/ 2 visits}).to_stdout

        stub_const('ARGV', [file_path, '-pu'])
        expect { Parser.run }.to(output(%r{/contact/ 2 unique visits}).to_stdout)
      end
    end
  end
end
