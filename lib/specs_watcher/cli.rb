require 'thor'

module SpecsWatcher
  class CLI < Thor

    desc "search --category=CATEGORY", "Search through Spec's Liquor Inventory"
    long_desc <<-EOS

      Categories:
        armagnac, blended_whiskey, bourbon, boutique_bourbon, brandy, canadian_whiskey, cocktails, cognac, cream_liqueurs, decanters, eau_de_vie, flavored_vodka, gift_liquor, gin, grappa, imported_vodka, irish_whisky, liqueur, miniatures_50ml, other_whiskeys, rum, scotch_blends, scotch_malts, tequila, tequila_super_premium, us_vodka, whiskey_flavored

    EOS
    option :category, aliases: :c, default: :bourbon
    option :verbose
    def search
      results = Searcher.search(options)
      print_table(SpecsWatcher::Formatter.array_hash_to_table(results))
    rescue SpecsWatcher::InvalidCategoryError => e
      say(e, :red)
    end

    desc "availability", "Check availability for an item by UPC and zip code"
    option :upc, required: true
    option :zip, required: true
    def availability
      results = Availability.search(options)
      puts results[:title]
      print_table(SpecsWatcher::Formatter.array_hash_to_table(results[:locations]))
    rescue SpecsWatcher::SpecsWatcherError => e
      say(e, :red)
    end
  end
end
