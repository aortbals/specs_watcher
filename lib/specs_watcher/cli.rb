require 'thor'

module SpecsWatcher
  class CLI < Thor
    def hello(name)
      puts "Hello #{name}"
    end
  end
end
