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
  end
end
