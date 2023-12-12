# frozen_string_literal: true

module Mutations
  module Rosters
    class DeleteRoster < BaseMutation
      field :roster, Types::RosterType, null: false

      argument :id, Integer, required: true

      def resolve(id:)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        roster = Roster.find(id)
        board = roster.board

        raise GraphQL::ExecutionError, 'Roster not found' unless roster.present?

        if roster.destroy
          board.rosters.where("position > ?", roster.position).update_all("position = position - 1")
        end

        { roster: }
      end
    end
  end
end
