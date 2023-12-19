# frozen_string_literal: true

module Mutations
  module Tasks
    class CreateTask < BaseMutation
      field :task, Types::TaskType, null: false

      argument :title, String, required: false
      argument :description, String, required: false
      argument :deadline, GraphQL::Types::ISO8601DateTime, required: false
      argument :assignee_id, Integer, required: true
      argument :priority_level, Types::TaskPriorityLevelType, required: true
      argument :roster_id, Integer, required: true
      argument :status, Types::TaskStatusType, required: true
      argument :position, Integer, required: false

      def resolve(**task_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        user = context[:current_user]

        task = user.tasks.build(task_input)
        roster = Roster.find(task_input[:roster_id])

        # Set display_order to the last one
        task.position = roster.tasks.maximum(:position).to_i + 1

        raise GraphQL::ExecutionError, task.errors.full_messages.join(', ') unless task.save

        notification_content_uk = "Вам призначено нове завдання: #{task.title}"
        notification_content_en = "You have been assigned a new task: #{task.title}"
        user.notifications.build(user_id: task.assignee_id, content_uk: notification_content_uk, content_en: notification_content_en, task: task).save

        { task: }
      end
    end
  end
end
