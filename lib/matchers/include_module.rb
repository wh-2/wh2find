require "rspec/expectations"

module Wh2find
  module Matchers

    def include_module(expected)
      IncludeModule.new expected
    end

    class IncludeModule

      def initialize(expected)
        @expected = expected
      end

      def matches?(actual)
        @model = actual.is_a?(Class) ? actual : actual.class
        @model.included_modules.include?(@expected)
      end

      def description
        'include #{@expected}'
      end

      def failure_message
        "expect #{@model.inspect} class to #{description}"
      end

      def failure_message_when_negated
        "expect #{@model.inspect} class to not #{description}"
      end
    end
  end
end