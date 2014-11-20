module SpecsWatcher
  SpecsWatcherError = Class.new(StandardError)
  InvalidCategoryError = Class.new(SpecsWatcherError)
  InvalidArgumentsError = Class.new(SpecsWatcherError)
end
