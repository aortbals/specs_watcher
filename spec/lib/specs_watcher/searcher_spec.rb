require 'spec_helper'

describe SpecsWatcher::Searcher do
  subject(:searcher) { SpecsWatcher::Searcher }

  describe '.search' do
    context 'default search' do
      it 'returns the first 1000 results from the inventory' do
        VCR.use_cassette('searcher_search_default_options') do
          expect(searcher.search.count).to eql(1000)
        end
      end

      it 'items have the correct attributes' do
        VCR.use_cassette('searcher_search_default_options') do
          results = searcher.search
          first = results.first
          expect(first[:title]).not_to be_empty
          expect(first[:price]).to be_a Float
          expect(first[:size]).not_to be_empty
          expect(first[:case_price]).to be_a Float
          expect(first[:case_size]).not_to be_empty
          expect(first[:upc]).not_to be_empty
          expect(first).not_to have_key(:description)
          expect(first).not_to have_key(:image)
        end
      end

      context 'option :verbose' do
        it 'returns results with additional attributes' do
          VCR.use_cassette('searcher_search_default_options') do
            results = searcher.search(verbose: true)
            expect(results.first).to have_key(:description)
            expect(results.first).to have_key(:image)
          end
        end
      end
    end

    context 'searching for bourbon' do
      it 'returns the full list of bourbons' do
        VCR.use_cassette('searcher_search_bourbon') do
          results = searcher.search(category: 'bourbon')
          expect(results.first[:title]).to match(/8 feathers/i)
        end
      end
    end

    context 'searching for "yamazaki"' do
      it 'returns results matching the keyword' do
        VCR.use_cassette('seracher_search_keyword_yamazaki') do
          results = searcher.search(keyword: 'yamazaki')
          expect(results.count).to eql(2)
          results.each do |r|
            expect(r[:title]).to match(/yamazaki/i)
          end
        end
      end
    end
  end
end
