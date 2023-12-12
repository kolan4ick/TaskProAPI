# frozen_string_literal: true

module Mutations
  module Boards
    class CreateBoard < BaseMutation
      field :board, Types::BoardType, null: false

      argument :project_id, Integer, required: false
      argument :title, String, required: false
      argument :description, String, required: false
      argument :cover_photo, ApolloUploadServer::Upload, required: false

      def resolve(**board_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        project = Project.find_by(id: board_input[:project_id])

        cover_photo = board_input[:cover_photo]

        if cover_photo.present?
          cover_photo_file = {
            io: StringIO.new(cover_photo.read),
            filename: cover_photo.original_filename,
            content_type: cover_photo.content_type
          }

          board_input[:cover_photo] = cover_photo_file
        end

        board = project.boards.build(board_input)

        # Set display_order to the last one
        board.position = project.boards.maximum(:position).to_i + 1

        raise GraphQL::ExecutionError, board.errors.full_messages.join(', ') unless board.save

        { board: }
      end
    end
  end
end
