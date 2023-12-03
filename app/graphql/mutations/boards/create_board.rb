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

        board = project.boards.build(board_input.except(:cover_image))

        cover_image = board_input[:cover_image]

        if cover_image.present?
          cover_image_file = {
            io: StringIO.new(cover_image.read),
            filename: cover_image.original_filename,
            content_type: cover_image.content_type
          }

          board_input[:cover_image] = cover_image_file
        end

        raise GraphQL::ExecutionError, board.errors.full_messages.join(', ') unless board.save

        { board: }
      end
    end
  end
end
