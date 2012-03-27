module Untitled
  class App
    attr_reader :root

    def initialize(root)
      @root = root
    end

    def endpoint
      this = self # Scopealope

      @endpoint ||= Rack::Builder.app do
        map "/assets" do
          run this.sprockets
        end

        map "/" do
          run Endpoint.new(this)
        end
      end
    end

    def sprockets
      @sprockets ||= Sprockets::Environment.new.tap do |env|
        env.append_path File.join(@root, "assets")
      end
    end
  end
end

