require "rack/utils"
require "rack/mime"
require "rack/builder"
require "tilt"

require "untitled/version"

require "untitled/mime_types"
Rack::Mime::MIME_TYPES.merge!(Untitled::MIME_TYPES)

require "untitled/app"

module Untitled; end
