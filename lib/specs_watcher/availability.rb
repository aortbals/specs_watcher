require_relative 'requests'

# curl 'http://www.specsonline.com/cgi-bin/showavail?upc=008099600274&zip=77008&x=0&y=0' -H 'DNT: 1' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: http://www.specsonline.com/cgi-bin/showavail?Form=showavail&upc=008099600274&dummy2=dummy&' -H 'Cookie: specsonline=11416499040204.128.208.187; _ga=GA1.2.1539204617.1416498811' -H 'Connection: keep-alive' --compressed

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
