require "rack/cascade"
require "sprockets"

require "untitled/configuration"
require "untitled/endpoint"

module Untitled
  class App
    attr_reader :root

    def initialize(root)
      @root = root
      @config = Configuration.new(config_path)
    end

    def endpoint
      @endpoint ||= Rack::Cascade.new([sprockets, Endpoint.new(self)])
    end

    def call(env)
      endpoint.call(env)
    end

    def sprockets
      @sprockets ||= Sprockets::Environment.new.tap do |env|
        @config.asset_paths.each do |asset_path|
          env.append_path asset_path
        end
      end
    end

    def config_path
      File.join(@root, "config.yml")
    end
  end
end

