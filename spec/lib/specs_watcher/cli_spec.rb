require 'spec_helper'

describe SpecsWatcher::CLI do
  describe '#search' do
    context 'without arguments' do
      it 'returns the first 1000 results from the inventory' do
        VCR.use_cassette('searcher_search_default_options') do
          content = capture(:stdout) { SpecsWatcher::CLI.start(%w[search]) }
          expect(content.lines.count).to eql(1001)
        end
      end
    end

    context "'s' alias" do
      it 'returns the first 1000 results from the inventory' do
        VCR.use_cassette('searcher_search_default_options') do
          content = capture(:stdout) { SpecsWatcher::CLI.start(%w[s]) }
          expect(content.lines.count).to eql(1001)
        end
      end
    end

    describe 'keyword' do
      context 'a bogus keyword' do
        it 'returns no results' do
          VCR.use_cassette('cli_keyword_bogus') do
            content = capture(:stdout) { SpecsWatcher::CLI.start(%w[search foobar]) }
            expect(content).to match(/No Results/)
          end
        end
      end

      context "searching for 'balvenie'" do
        it "returns results for 'balvenie'" do
          VCR.use_cassette('cli_search_keyword_balvenie') do
            content = capture(:stdout) { SpecsWatcher::CLI.start(%w[search balvenie]) }
            expect(content.lines[1]).to match(/balvenie/i)
          end
        end
      end
    end

    describe 'option :category' do
      shared_examples_for 'category bourbon' do
        it 'returns the full list of bourbons' do
          VCR.use_cassette('searcher_search_bourbon') do
            content = capture(:stdout) { SpecsWatcher::CLI.start(command) }
            expect(content.lines[1]).to match(/8 feathers/i)
          end
        end
      end

      context '--category bourbon' do
        let(:command) { %w[search --category bourbon] }
        it_behaves_like 'category bourbon'
      end

      context '-c bourbon' do
        let(:command) { %w[search -c bourbon] }
        it_behaves_like 'category bourbon'
      end

      context 'non-existent category' do
        it 'prints a useful error' do
          content = capture(:stdout) { SpecsWatcher::CLI.start(%w[search -c bubbles]) }
          expect(content.lines.first).to match(/'bubbles' is not a valid category/i)
        end
      end
    end

    describe 'option :verbose' do
      shared_examples_for 'verbose' do
        it 'returns additional columns' do
          VCR.use_cassette('searcher_search_default_options') do
            content = capture(:stdout) { SpecsWatcher::CLI.start(command) }
            expect(content.lines.first).to match(/description/i)
            expect(content.lines.first).to match(/image/i)
          end
        end
      end

      context '--verbose' do
        let(:command) { %w[search --verbose] }
        it_behaves_like 'verbose'
      end

      context '-v' do
        let(:command) { %w[search -v] }
        it_behaves_like 'verbose'
      end
    end
  end

  describe '#availability' do
    shared_examples_for 'availability' do
      it 'returns a list of locations' do
        VCR.use_cassette('cli_availability') do
          content = capture(:stdout) { SpecsWatcher::CLI.start(command) }
          expect(content.lines[1]).to match(/Store name/i)
          expect(content.lines[1]).to match(/Availability/i)
        end
      end
    end

    context 'availability' do
      let(:command) { %w[availability 78751 085457000211] }
      it_behaves_like 'availability'
    end

    context "'a' alias" do
      let(:command) { %w[a 78751 085457000211] }
      it_behaves_like 'availability'
    end
  end
end
