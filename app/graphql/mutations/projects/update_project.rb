# frozen_string_literal: true

module Mutations
  module Projects
    class UpdateProject < BaseMutation
      field :project, Types::ProjectType, null: false

      argument :id, ID, required: true
      argument :title, String, required: false
      argument :description, String, required: false
      argument :icon, ApolloUploadServer::Upload, required: false

      def resolve(id:, **project_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        project = Project.find(id)

        raise GraphQL::ExecutionError, 'Project not found' unless project.present?

        project.update(project_input.except(:icon))

        { project: }
      end
    end
  end
end