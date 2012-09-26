module Untitled
  class Configuration
    attr_accessor :asset_paths

    DEFAULT_ASSET_PATHS = %w[
      app/javascripts
      app/stylesheets
      vendor/javascripts
      vendor/stylesheets
    ]

    def initialize(file_path)
      self.asset_paths = DEFAULT_ASSET_PATHS
    end
  end
end
