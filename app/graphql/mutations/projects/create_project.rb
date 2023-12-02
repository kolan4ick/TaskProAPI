# frozen_string_literal: true

module Mutations
  module Projects
    class CreateProject < BaseMutation
      field :project, Types::ProjectType, null: false

      argument :title, String, required: true
      argument :description, String, required: true
      argument :icon, ApolloUploadServer::Upload, required: false

      def resolve(**project_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        project = Project.new(project_input.except(:icon))

        icon = project_input[:icon]

        if icon.present?
          icon_file = {
            io: StringIO.new(icon.read),
            filename: icon.original_filename,
            content_type: icon.content_type
          }

          project_input[:icon] = icon_file
        end

        raise GraphQL::ExecutionError, project.errors.full_messages.join(', ') unless project.save

        { project: }
      end
    end
  end
end
