# frozen_string_literal: true

module Mutations
  module Rosters
    class UpdateRoster < BaseMutation
      field :roster, Types::RosterType, null: false

      argument :id, Integer, required: true
      argument :board_id, Integer, required: false
      argument :title, String, required: false
      argument :position, Integer, required: false

      def resolve(id:, **roster_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        roster = Roster.find(id)

        raise GraphQL::ExecutionError, 'Roster not found' unless roster.present?

        # Change position for all rosters if it was changed
        if roster.position != roster_input[:position] && roster_input[:position].present?
          if roster.position > roster_input[:position]
            Roster.where("position >= ? AND position < ?", roster_input[:position], roster.position).update_all("position = position + 1")
          else
            Roster.where("position <= ? AND position > ?", roster_input[:position], roster.position).update_all("position = position - 1")
          end
        end

        roster.update(roster_input)

        raise GraphQL::ExecutionError, roster.errors.full_messages.join(', ') unless roster.save

        { roster: }
      end
    end
  end
end
