require 'thor'

module SpecsWatcher
  class CLI < Thor

    desc "search --category=CATEGORY", "Search through Spec's Liquor Inventory"
    long_desc <<-EOS

      Categories:
        armagnac, blended_whiskey, bourbon, boutique_bourbon, brandy, canadian_whiskey, cocktails, cognac, cream_liqueurs, decanters, eau_de_vie, flavored_vodka, gift_liquor, gin, grappa, imported_vodka, irish_whisky, liqueur, miniatures_50ml, other_whiskeys, rum, scotch_blends, scotch_malts, tequila, tequila_super_premium, us_vodka, whiskey_flavored

    EOS
    option :category, aliases: :c
    option :verbose
    def search(keyword=nil)
      searcher_options = options.dup
      searcher_options.merge!({keyword: keyword}) if keyword
      results = Searcher.search(searcher_options)

      if results.any?
        print_table(SpecsWatcher::Formatter.array_hash_to_table(results))
      else
        puts "No Results."
      end
    rescue SpecsWatcher::InvalidCategoryError => e
      say(e, :red)
    end

    desc "availability ZIP UPC", "Check availability for an item by zip code and UPC"
    def availability(zip, upc)
      results = Availability.search({ zip: zip, upc: upc })
      puts results[:title]
      print_table(SpecsWatcher::Formatter.array_hash_to_table(results[:locations]))
    rescue SpecsWatcher::SpecsWatcherError => e
      say(e, :red)
    end
  end
end
