require "rspec/expectations"

module Wh2find
  module Matchers
    def have_callback_for(event)
      HaveCallbackFor.new event
    end

    class HaveCallbackFor
      def initialize(event)
        @event = event
      end

      def triggering(kind)
        @kind = kind
        self
      end

      def with_function(name)
        @function_name = name
        self
      end

      # def resulting_in(&block)
      #   @block = block
      #   self
      # end

      def matches?(actual)
        # byebug
        @model = actual
        callbacks = actual.send("_#{@event}_callbacks")

        if callbacks.empty?
          @is_expected = "to have callback for event #{@event}"
          return false
        end

        if @kind
          callbacks = callbacks.select { |cb| cb.kind.eql?(@kind) }
          if callbacks.empty?
            @is_expected = "to have callbacks for event #{@event} triggering #{@kind}"
            return false
          end
        end

        if @function_name and not(callbacks.collect(&:filter).include?(@function_name))
          @is_expected = "to have callback with function @function_name"
          return false
        end
        true
      end

      def description
        'have callback'
      end

      def failure_message
        "expect #{@model.inspect} #{@is_expected}"
      end

      def failure_message_when_negated
        "expect #{@model.inspect} class to not #{@is_expected}"
      end
    end
  end
end