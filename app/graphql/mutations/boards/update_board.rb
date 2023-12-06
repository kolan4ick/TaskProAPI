# frozen_string_literal: true

module Mutations
  module Boards
    class UpdateBoard < BaseMutation
      field :board, Types::BoardType, null: false

      argument :id, ID, required: true
      argument :title, String, required: false
      argument :description, String, required: false
      argument :cover_image, ApolloUploadServer::Upload, required: false
      argument :position, Integer, required: false

      def resolve(**board_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        board = Board.find(board_input[:id])

        cover_image = board_input[:cover_image]

        if cover_image.present?
          cover_image_file = {
            io: StringIO.new(cover_image.read),
            filename: cover_image.original_filename,
            content_type: cover_image.content_type
          }

          board_input[:cover_image] = cover_image_file
        end

        # Change position for all boards if it was changed
        if board.position != board_input[:position] && board_input[:position].present?
          if board.position > board_input[:position]
            Board.where("position >= ? AND position < ?", board_input[:position], board.position).update_all("position = position + 1")
          else
            Board.where("position <= ? AND position > ?", board_input[:position], board.position).update_all("position = position - 1")
          end
        end

        raise GraphQL::ExecutionError, board.errors.full_messages.join(', ') unless board.update(board_input.except(:id))

        { board: }
      end
    end
  end
end
