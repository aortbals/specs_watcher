require_relative 'requests'

module SpecsWatcher
  class Availability
    include SpecsWatcher::Requests

    def self.search(options = {})
      new.search(options)
    end

    def search(options)
      raise SpecsWatcher::InvalidCategoryError, "'upc' and 'zip' are required" unless options[:upc] && options[:zip]
      response = make_request(path, options.merge({x: '0', y: '0'}))
      Parsers::Availability.parse(response.body)
    end

    private

    def path
      '/showavail'
    end
  end
end
