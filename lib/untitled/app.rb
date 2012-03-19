module Untitled
  class App
    SEPS = Regexp.union(*[::File::SEPARATOR, ::File::ALT_SEPARATOR].compact)

    class NotFoundError < Exception; end

    def initialize(root)
      @root = root
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      @url_path = Rack::Utils.unescape(env["PATH_INFO"])

      deny_template!

      extract_system_path!

      serve_index if File.directory?(@system_path)

      search = Dir.glob("{#@system_path,#@system_path.?*}")

      raise NotFoundError unless file = search.first

      extensions = File.basename(file).split(".")
      contents = File.read(file)

      context = Context.new(self)

      while extension = extensions.pop
        if template = Tilt[extension]
          template = template.new(nil) { contents }
          contents = template.render(context)
        else
          break
        end
      end

      success_response(contents)
    rescue NotFoundError
      not_found_response
    end

    def denied_extensions
      Tilt.mappings.keys + ["rb"]
    end

    private

    def deny_template!
      url_extension = File.extname(@url_path).gsub(".", "")

      if url_extension.length > 0 && denied_extensions.include?(url_extension)
        raise NotFoundError
      end
    end

    def extract_system_path!
      parts = @url_path.split SEPS

      # Ensure the requested file is contained in the @root
      parts.inject(0) do |depth, part|
        case part
        when '', '.'
          depth
        when '..'
          raise NotFoundError if depth - 1 < 0
          depth - 1
        else
          depth + 1
        end
      end

      @system_path = File.join(@root, *parts)
    end

    def serve_index
      @url_path = File.join(@url_path, "index.html")
      @system_path = File.join(@system_path, "index.html")
    end

    def success_response(contents)
      # Get MIME type for file
      ext = File.extname(@url_path)
      mime = Rack::Mime.mime_type(ext)

      [
        200,
        {
          "Content-Type" => mime,
          "Content-Length" => contents.size.to_s
        },
        [contents]
      ]
    end

    def not_found_response
      error_response(404, "Not Found")
    end

    def error_response(status, body)
      # Base headers
      headers = {
        "Content-Type" => "text/plain",
        "Content-Length" => body.size.to_s
      }

      # Support Rack cascading
      headers["X-Cascade"] = "pass" if status == 404

      # Rackify!
      [
        status,
        headers,
        [body]
      ]
    end
  end
end

