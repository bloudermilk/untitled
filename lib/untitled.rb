require "tilt"
require "rack/utils"
require "rack/mime"

require "untitled/version"

require "untitled/mime_types"
Rack::Mime::MIME_TYPES.merge!(Untitled::MIME_TYPES)

require "untitled/app"
require "untitled/context"

module Untitled
  # Your code goes here...
end
