require 'hasura_handler/engine'
require 'hasura_handler/authenticator'
require 'hasura_handler/event_handler'
require 'hasura_handler/event_processor'
require 'hasura_handler/event'
require 'hasura_handler/action'

module HasuraHandler
  class << self
    mattr_accessor :auth_header,
                   :auth_key,
                   :authentication_enabled,
                   :authenticator,
                   :events_enabled,
                   :actions_enabled,
                   :event_job_queue,
                   :event_handler_job_queue,
                   :async_events,
                   :fanout_events

    self.auth_header = 'HTTP_X_HASURA_SERVICE_KEY'
    self.authentication_enabled = false
    self.authenticator = nil
    self.events_enabled = true
    self.async_events = true
    self.fanout_events = true
    self.actions_enabled = true
    self.event_job_queue = :hasura_event
    self.event_handler_job_queue = :hasura_event
  end

  def self.setup(&block)
    yield self

    if (self.events_enabled || self.actions_enabled) && self.auth_key.blank?
      raise 'HasuraHandler requires the auth_key to be configured if actions or events are enabled.'
    end

    if self.authentication_enabled && self.authenticator.blank?
      raise 'HasuraHandler requires the authenticator to be configured if authentication hook is enabled.'
    end
  end
end
