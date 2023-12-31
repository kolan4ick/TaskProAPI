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

      def resolve(**task_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        task = Task.find(task_input[:id])
        roster = Roster.find(task_input[:roster_id])

        raise GraphQL::ExecutionError, 'Task not found' unless task

        # Add task to another roster if it was changed and change it position to the last
        if task.roster_id != task_input[:roster_id] && task_input[:roster_id].present?
          raise GraphQL::ExecutionError, task.errors.full_messages.join(', ') unless task.update(roster_id: task_input[:roster_id], position: roster.tasks.maximum(:position).to_i + 1)
        end

        # Change position for all tasks if it was changed
        if task.position != task_input[:position] && task_input[:position].present?
          if task.position > task_input[:position]
            roster.tasks.where("position >= ? AND position < ?", task_input[:position], task.position).update_all("position = position + 1")
          else
            roster.tasks.where("position <= ? AND position > ?", task_input[:position], task.position).update_all("position = position - 1")
          end
        end

        assignee = task.assignee

        raise GraphQL::ExecutionError, task.errors.full_messages.join(', ') unless task.update(task_input.to_h)

        # Send notification to assignee if it was changed
        if task.assignee_id != task_input[:assignee_id] && task_input[:assignee_id].present?
          notification_content_uk = "Вам призначено нове завдання: #{task.title}"
          notification_content_en = "You have been assigned a new task: #{task.title}"
          assignee.notifications.build(user_id: task.assignee_id, content_uk: notification_content_uk, content_en: notification_content_en, task: task).save
        end

        { task: }
      end
    end
  end
end
