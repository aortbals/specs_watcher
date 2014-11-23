require 'typhoeus'

module SpecsWatcher
  module Requests
    protected

    def base_uri
      "http://www.specsonline.com/cgi-bin"
    end

    def make_request(path, params = {})
      Typhoeus.get(base_uri + path,
        method: :get,
        params: params,
        headers: headers,
        accept_encoding: 'gzip')
    end

    def headers
      {
        'DNT' => '1',
        'Accept-Language' => 'en-US,en;q=0.8',
        'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36',
        'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Referer' => 'http://www.specsonline.com/cgi-bin/search?keyword=&inclass=Liquors&webclass=Liquors&subclass=130&origin=&region=&size=&Sortby=Name&pricefrom=&pricethru=&',
        'Connection' => 'keep-alive'
      }
    end
  end
end
