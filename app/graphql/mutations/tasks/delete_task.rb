# frozen_string_literal: true

module Mutations
  module Tasks
    class DeleteTask < BaseMutation
      field :task, Types::TaskType, null: false

      argument :id, Integer, required: true

      def resolve(id:)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        task = Task.find_by(id:)
        board = task.board

        raise GraphQL::ExecutionError, 'Task not found' unless task.present?

        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].id == task.user_id

        if task.destroy
          board.tasks.where("position > ?", task.position).update_all("position = position - 1")
        end

        { task: }
      end
    end
  end
end
