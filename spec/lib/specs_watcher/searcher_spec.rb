require 'spec_helper'

describe SpecsWatcher::Searcher do
  subject(:searcher) { SpecsWatcher::Searcher }

  describe '.search' do
    context 'default options' do
      it 'returns a list of results with the correct attributes' do
        VCR.use_cassette('searcher_search_default_options') do
          results = searcher.search
          first = results.first

          expect(first[:image]).not_to be_empty
          expect(first[:title]).not_to be_empty
          expect(first).not_to have_key(:description)
          expect(first[:size]).not_to be_empty
          expect(first[:price]).to be_a Float
          expect(first[:case_price]).to be_a Float
          expect(first[:case_size]).not_to be_empty
        end
      end

      context 'option :include_description' do
        it 'returns results with the descriptions included' do
          VCR.use_cassette('searcher_search_default_options') do
            expect(searcher.search(include_description: true).first).to have_key(:description)
          end
        end
      end
    end
  end
end
