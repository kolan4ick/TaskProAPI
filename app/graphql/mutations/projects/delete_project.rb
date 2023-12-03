# frozen_string_literal: true

module Mutations
  module Projects
    class DeleteProject < BaseMutation
      field :project, Types::ProjectType, null: false

      argument :id, ID, required: true

      def resolve(id:)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        project = Project.find(id)

        raise GraphQL::ExecutionError, 'Project not found' unless project.present?

        project.destroy

        { project: }
      end
    end
  end
end
