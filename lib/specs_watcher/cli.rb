require 'thor'

module SpecsWatcher
  class CLI < Thor

    desc "search --category CATEGORY", "Search through Spec's Liquor Inventory"
    option :category
    def search
      puts Searcher.search(options)
    rescue SpecsWatcher::InvalidCategoryError => e
      say(e, :red)
    end
  end
end
