require_relative 'requests'

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
