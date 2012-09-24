require "untitled"

require "untitled/command/new"

module Untitled
  module Command
    class << self
      def run(command, args)
        command_class = Untitled::Command.const_get(command.capitalize)
        command_class.new(args).run
      end
    end
  end
end
