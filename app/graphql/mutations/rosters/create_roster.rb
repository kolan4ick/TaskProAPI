# frozen_string_literal: true

module Mutations
  module Rosters
    class CreateRoster < BaseMutation
      field :roster, Types::RosterType, null: false

      argument :board_id, Integer, required: false
      argument :title, String, required: false

      def resolve(**roster_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        roster = Roster.new(roster_input)

        raise GraphQL::ExecutionError, roster.errors.full_messages.join(', ') unless roster.save

        { roster: roster }
      end
    end
  end
end
