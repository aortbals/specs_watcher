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
          expect(first[:size]).not_to be_empty
          expect(first[:price]).to be_a Float
          expect(first[:case_price]).to be_a Float
          expect(first[:case_size]).not_to be_empty
        end
      end
    end
  end
end
