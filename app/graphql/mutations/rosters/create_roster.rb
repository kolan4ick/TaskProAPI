# frozen_string_literal: true

module Mutations
  module Rosters
    class CreateRoster < BaseMutation
      field :roster, Types::RosterType, null: false

      argument :board_id, Integer, required: false
      argument :title, String, required: false

      def resolve(**roster_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        board = Board.find(roster_input[:board_id])
        roster = Roster.new(roster_input)

        # Set display_order to the last one
        roster.position = board.rosters.maximum(:position).to_i + 1

        raise GraphQL::ExecutionError, roster.errors.full_messages.join(', ') unless roster.save

        { roster: }
      end
    end
  end
end
