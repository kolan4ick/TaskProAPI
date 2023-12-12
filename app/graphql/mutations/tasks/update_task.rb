# frozen_string_literal: true

module Mutations
  module Tasks
    class UpdateTask < BaseMutation
      field :task, Types::TaskType, null: false

      argument :id, ID, required: true
      argument :title, String, required: false
      argument :description, String, required: false
      argument :deadline, GraphQL::Types::ISO8601DateTime, required: false
      argument :assignee_id, Integer, required: false
      argument :priority_level, Types::TaskPriorityLevelType, required: false
      argument :roster_id, Integer, required: true
      argument :status, Types::TaskStatusType, required: false
      argument :position, Integer, required: false

      def resolve(task_input:)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        task = Task.find(task_input[:id])
        board = Board.find(task_input[:board_id])

        raise GraphQL::ExecutionError, 'Task not found' unless task

        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].id == task.user_id

        # Change position for all tasks if it was changed
        if task.position != task_input[:position] && task_input[:position].present?
          if task.position > task_input[:position]
            board.tasks.where("position >= ? AND position < ?", task_input[:position], task.position).update_all("position = position + 1")
          else
            board.tasks.where("position <= ? AND position > ?", task_input[:position], task.position).update_all("position = position - 1")
          end
        end

        raise GraphQL::ExecutionError, task.errors.full_messages.join(', ') unless task.update(task_input.to_h)

        { task: }
      end
    end
  end
end
