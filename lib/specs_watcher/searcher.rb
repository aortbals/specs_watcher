require_relative 'requests'

# Keyword search for 'yamazaki' without a sub-category
# curl 'http://www.specsonline.com/cgi-bin/search?keyword=yamazaki&inclass=Liquors&webclass=Liquors&subclass=&origin=&region=&size=&Sortby=Name&pricefrom=&pricethru=&' -H 'Pragma: no-cache' -H 'DNT: 1' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: http://www.specsonline.com/cgi-bin/showpage?pageid=search&keyword=yamazaki&inclass=Liquors&webclass=Liquors&subclass=&origin=&region=&size=&Sortby=Name&pricefrom=&pricethru=&' -H 'Cookie: zip=77008; specsonline=11416270248204.128.208.187; _gat=1; _ga=GA1.2.1582335722.1416270044' -H 'Connection: keep-alive' -H 'Cache-Control: no-cache' --compressed

# 'bourbon' sub-category without keyword, all results
# curl 'http://www.specsonline.com/cgi-bin/search?pageid=search&keyword=&inclass=Liquors&webclass=Liquors&subclass=120&origin=&region=&size=&Sortby=Name&pricefrom=&pricethru=&showmax=1000&noask=noask&submit=Click+to+Show+More' -H 'Pragma: no-cache' -H 'DNT: 1' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: http://www.specsonline.com/cgi-bin/search?keyword=&inclass=Liquors&webclass=Liquors&subclass=120&origin=&region=&size=&Sortby=Name&pricefrom=&pricethru=&' -H 'Cookie: zip=77008; specsonline=11416270248204.128.208.187; _gat=1; _ga=GA1.2.1582335722.1416270044' -H 'Connection: keep-alive' -H 'Cache-Control: no-cache' --compressed

# default search, max results of 1000
# curl 'http://www.specsonline.com/cgi-bin/search?pageid=search&keyword=&inclass=Liquors&webclass=Liquors&subclass=&origin=&region=&size=&Sortby=Name&pricefrom=&pricethru=&showmax=1000&noask=noask&submit=Click+to+Show+More' -H 'Pragma: no-cache' -H 'DNT: 1' -H 'Accept-Encoding: gzip,deflate,sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/38.0.2125.122 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8' -H 'Referer: http://www.specsonline.com/cgi-bin/search?keyword=&inclass=Liquors&webclass=Liquors&subclass=&origin=&region=&size=&Sortby=Name&pricefrom=&pricethru=&' -H 'Cookie: zip=77008; specsonline=11416270248204.128.208.187; _gat=1; _ga=GA1.2.1582335722.1416270044' -H 'Connection: keep-alive' -H 'Cache-Control: no-cache' --compressed

module SpecsWatcher
  class Searcher
    include SpecsWatcher::Requests

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
      response = make_request(path, params(options))
      results = Parsers::Searcher.parse(response.body)
      unless options[:verbose]
        results.each { |r| r.delete :description }
        results.each { |r| r.delete :image }
      end
      results
    end

    private

    def path
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
        keyword: override[:keyword],
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
      end
    end
  end
end
