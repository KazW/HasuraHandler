module HasuraHandler
  class EventJob < ApplicationJob
    queue_as HasuraHandler.event_job_queue

    def perform(event)
      HasuraHandler::EventHandler.new(event).process
    end
  end
end
