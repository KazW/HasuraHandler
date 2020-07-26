module HasuraHandler
  class Event
    attr_reader :id,
                :table,
                :trigger,
                :event,
                :created_at,
                :raw_event,
                :errors,
                :valid

    def initialize(event)
      @id = event['id']
      @table = event['table']
      @trigger = event['trigger']
      @event = event['event']
      @created_at = event['created_at']
      @raw_event = event
      @errors = {}

      [
        :validate_simple_fields,
        :validate_table,
        :validate_trigger,
        :validate_event
      ].each{ |check| self.send(check) }
    end

    def valid?
      @errors.blank?
    end

    private

    def validate_simple_fields
      [
        :id,
        :created_at
      ].each do |field|
        @errors[field.to_s] = 'missing' unless self.send(field).present?
      end
    end

    def validate_table
      unless @table.is_a?(Hash)
        @errors['table'] = 'not a hash'
        return
      end

      string_fields?(@table, 'table', [:schema, :name])
    end

    def validate_trigger
      unless @trigger.is_a?(Hash)
        @errors['trigger'] = 'not a hash'
        return
      end

      string_fields?(@trigger, 'trigger', [:name])
    end

    def validate_event
      unless @event.is_a?(Hash)
        @errors['event'] = 'not a hash'
        return
      end

      @errors['event.session_variables'] = 'not a hash' unless @event['session_variables'].is_a?(Hash)
      string_fields?(@event, 'event', [:op])

      [:new, :old].each do |field|
        unless @event[field].nil? || @event[field].is_a?(Hash)
          @errors["event.data.#{field}"] = 'not a hash'
        end
      end
    end

    def string_fields?(field, error_key, subfields)
      subfields.each do |subfield|
        unless field[subfield].present? && field[subfield].is_a?(String)
          errors["#{error_key}.#{subfield}"] = 'missing'
        end
      end
    end
  end
end
