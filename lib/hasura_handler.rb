require 'hasura_handler/engine'
require 'hasura_handler/event_handler'
require 'hasura_handler/event_processor'
require 'hasura_handler/event'
require 'hasura_handler/action'

module HasuraHandler
  class << self
    mattr_accessor :auth_header,
                   :auth_key,
                   :events_enabled,
                   :actions_enabled,
                   :event_job_queue,
                   :event_handler_job_queue,
                   :async_events,
                   :fanout_events,
                   :retry_after

    self.auth_header = 'HTTP_X_HASURA_SERVICE_KEY'
    self.events_enabled = true
    self.async_events = true
    self.fanout_events = true
    self.actions_enabled = true
    self.event_job_queue = :hasura_event
    self.event_handler_job_queue = :hasura_event
    self.retry_after = 5
  end

  def self.setup(&block)
    yield self
    [:auth_key].each do |key|
      raise "HasuraHandler requires the #{key} to be configured." if self.send(key).blank?
    end
  end
end
