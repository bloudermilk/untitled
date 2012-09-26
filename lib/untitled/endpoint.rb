require "untitled/context"

module Untitled
  class Endpoint
    SEPS = Regexp.union(*[::File::SEPARATOR, ::File::ALT_SEPARATOR].compact)

    def initialize(app)
      @app = app
    end

    def call(env)
      url_path = Rack::Utils.unescape(env["PATH_INFO"])

      #if out_of_root_requested?(url_path) || template_requested?(url_path)
      #  not_found_response
      #else
        # TODO: Need a pages_path on app...
        system_path = File.join(@app.root, "app", "pages", url_path)

      #  if directory_requested?(system_path)
      #    serve_index(system_path)
      #  else
          serve_file(system_path)
      #  end
      #end
    end

    def out_of_root_requested?(url_path)
      parts = url_path.split SEPS

      depth = parts.inject(0) do |depth, part|
        case part
        when '', '.'
          depth
        when '..'
          depth - 1
        else
          depth + 1
        end
      end

      depth < 0
    end

    def template_requested?(url_path)
      url_extension = File.extname(url_path).gsub(".", "")
      url_extension.length > 0 && denied_extensions.include?(url_extension)
    end

    def directory_requested?
      File.directory?(@system_path)
    end

    def serve_index(system_path)
      system_path = File.join(system_path, "index.html")

      serve_file(system_path)
    end

    def serve_file(system_path)
      search = Dir.glob("{#{system_path},#{system_path}.*}")

      if file = search.first
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

        success_response(extension, contents)
      else
        not_found_response
      end
    end

    def success_response(extension, contents)
      # Get MIME type for file
      mime = Rack::Mime.mime_type("." + extension)

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

      [
        status,
        headers,
        [body]
      ]
    end

    def template_extensions
      Tilt.mappings.keys
    end
  end
end
