module HasuraHandler
  class EventHandler
    class << self
      attr_reader :hasura_matchers

      def match_by(matchers)
        raise 'matcher must be a hash' unless matchers.is_a?(Hash)
        allowed_matchers = [:table, :trigger, :op]

        matchers.keys.each do |matcher|
          raise 'invalid matcher' unless allowed_matchers.include?(matcher)
          raise 'invalid matcher value' unless matchers[matcher].is_a?(String)
        end

        @hasura_matchers = matchers
      end
    end

    attr_reader :event

    def initialize(event)
      @event = event
    end
  end
end
