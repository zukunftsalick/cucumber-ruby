require 'cucumber/formatter/progress'
require 'cucumber/step_definition_light'

module Cucumber
  module Formatter
    class Debug
      def initialize(runtime, io, options)
        @io = io
        @indent = 0
      end

      def log(message)
        return unless ENV['DEBUG']
        @io.puts "* #{message}"
      end

      def respond_to?(*args)
        true
      end

      def method_missing(name, *args)
        @indent -= 2 if name.to_s =~ /^after/
        print(name)
        @indent += 2 if name.to_s =~ /^before/
      end

      def puts(*args)
        print("puts")
      end

    private

      def print(text)
        @io.puts "#{indent}#{text}"
      end

      def indent
        (' ' * @indent)
      end
    end
  end
end
