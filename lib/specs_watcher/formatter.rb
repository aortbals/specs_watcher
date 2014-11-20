module SpecsWatcher
  module Formatter
    def self.array_hash_to_table(hash)
      header = [hash.first.keys.map{|s| s.to_s.capitalize.gsub('_', ' ')}]
      table = hash.map { |i| i.values }
      header + table
    end
  end
end
