module HasuraHandler
  class Action
    @@hasura_actions = {}
    class << self
      attr_reader :hasura_action_name

      def action_name(action_name)
        raise 'run method not defined' unless new(nil, nil).respond_to?(:run)
        raise 'action_name must be a symbol or string' unless action_name.is_a?(Symbol) || action_name.is_a?(String)
        raise 'action_name already used' if @@hasura_actions.keys.include?(action_name.to_s)

        @@hasura_actions[action_name.to_s] = self
        @hasura_action_name = action_name.to_s
      end

      def hasura_actions
        @@hasura_actions
      end
    end

    attr_reader :session_variables,
                :input,
                :output,
                :error_message

    def initialize(session_variables, input)
      @session_variables = session_variables
      @input = input
      @output = {}
    end
  end
end
