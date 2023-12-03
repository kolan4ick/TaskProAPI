# frozen_string_literal: true

module Mutations
  module Boards
    class DeleteBoard < BaseMutation
      field :board, Types::BoardType, null: false

      argument :id, ID, required: true

      def resolve(id:)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        board = Board.find(id)

        raise GraphQL::ExecutionError, 'Board not found' unless board.present?

        board.destroy

        { board: }
      end
    end
  end
end
