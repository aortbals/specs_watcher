require 'thor'

module SpecsWatcher
  class CLI < Thor

    desc "search --category CATEGORY", "Search through Spec's Liquor Inventory"
    option :category, aliases: :c, default: :bourbon
    option :verbose
    def search
      results = Searcher.search(options)
      print_table(SpecsWatcher::Formatter.array_hash_to_table(results))
    rescue SpecsWatcher::InvalidCategoryError => e
      say(e, :red)
    end

    desc "availability --upc UPC --zip ZIP", "Check availability for an item by UPC and zip code"
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
