module HasuraHandler
  class EventProcessor
    attr_accessor :event

    def initialize(event)
      @event = HasuraHandler::Event.new(event)
    end

    def process_later
      HasuraHandler::EventJob.perform_later(@event.raw_event)
    end

    def process
      event_handlers.each do |handler_class|
        if HasuraHandler.fanout_events
          HasuraHandler::EventHandlerJob.perform_later(handler_class.to_s, @event.raw_event)
        else
          handler = handler_class.new(@event)
          handler.run
        end
      end
    end

    private

    def event_handlers
      HasuraHandler::EventHandler.
      descendants.
      map{ |klass| [klass, klass.hasura_matchers] }.
      to_h.
      map{ |klass,matchers| [klass, check_matchers(matchers)] }.
      to_h.
      select{ |klass,match| match }.
      keys
    end

    def check_matchers(matchers)
      matchers.all? do |matcher|
        @event.send(matcher.first) == matcher.last
      end
    end
  end
end
