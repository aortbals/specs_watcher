require 'typhoeus'

module SpecsWatcher
  class Searcher
    def self.search(options = {})
      new.search(options)
    end

    def self.sub_categories
      {
        armagnac: "145",
        blended_whiskey: "135",
        bourbon: "120",
        boutique_bourbon: "130",
        brandy: "140",
        canadian_whiskey: "125",
        cocktails: "160",
        cognac: "150",
        cream_liqueurs: "221",
        decanters: "270",
        eau_de_vie: "158",
        flavored_vodka: "286",
        gift_liquor: "275",
        gin: "180",
        grappa: "155",
        imported_vodka: "285",
        irish_whisky: "200",
        liqueur: "220",
        miniatures_50ml: "290",
        other_whiskeys: "258",
        rum: "240",
        scotch_blends: "250",
        scotch_malts: "255",
        tequila: "260",
        tequila_super_premium: "265",
        us_vodka: "280",
        whiskey_flavored: "121"
      }
    end

    def search(options)
      response = make_request(search_path, params(options))
      results = Parser.parse(response.body)
      results.each { |r| r.delete :description } unless options[:include_description]
      results
    end

    private

    def base_uri
      "http://www.specsonline.com/cgi-bin"
    end

    def search_path
      "/search"
    end

    def params(override = {})
      {
        pageid: 'search',
        inclass: 'Liquors',
        webclass: 'Liquors',
        subclass: category(override[:category]),
        showmax: 1000,
        noask: 'noask',
        submit: 'Click to Show More',
        keyword: nil,
        origin: nil,
        size: nil,
        region: nil,
        pricefrom: nil,
        pricethru: nil,
        "Sortby" => 'Name'
      }
    end

    def category(key)
      if key
        value = self.class.sub_categories[key.to_sym]
        raise SpecsWatcher::InvalidCategoryError, "'#{key}' is not a valid category" unless value
        value
      else
        self.class.sub_categories[:bourbon]
      end
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
        'Cookie' => 'specsonline=11416499040204.128.208.187; _gat=1; _ga=GA1.2.1539204617.1416498811',
        'Connection' => 'keep-alive'
      }
    end
  end
end
