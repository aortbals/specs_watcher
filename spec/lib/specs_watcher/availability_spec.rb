require 'spec_helper'

describe SpecsWatcher::Availability do
  subject(:availability) { SpecsWatcher::Availability }

  describe '.search' do
    context 'default options' do
      it 'returns a list of results with the correct attributes' do
        VCR.use_cassette('availability_search_default_options') do
          results = availability.search(upc: '085457000211', zip: '77008')
          first_location = results[:locations].first

          expect(results[:title]).to match(/smooth ambler/i)
          expect(first_location[:store_name]).to_not be_empty
          expect(first_location[:availability]).to_not be_empty
        end
      end
    end
  end
end
