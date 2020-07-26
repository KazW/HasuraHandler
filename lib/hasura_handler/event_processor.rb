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

      if event_handlers.size == 0
        Rails.logger.debug('[HasuraHandler] Received event with no matching handlers.')
      end
    end

    private

    def event_handlers
      HasuraHandler::EventHandler.
      descendants.
      map{ |klass| [klass, klass.hasura_matchers] }.
      to_h.
      select{ |klass, matchers| matchers.present? }.
      map{ |klass,matchers| [klass, check_matchers(matchers)] }.
      to_h.
      select{ |klass,match| match }.
      keys
    end

    def check_matchers(matchers)
      matchers.all? do |field,value|
        @event.send(field) == value
      end
    end
  end
end
