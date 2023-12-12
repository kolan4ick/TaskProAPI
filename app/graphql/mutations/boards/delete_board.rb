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

        if board.destroy
          project = board.project
          project.boards.where("position > ?", board.position).update_all("position = position - 1")
        end

        { board: }
      end
    end
  end
end
