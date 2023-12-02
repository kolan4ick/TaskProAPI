# frozen_string_literal: true

module Types
  class TaskStatusType < Types::BaseEnum
    description "Task status enum"

    value 'not_started', 'Task has not been started', value: 'not_started'
    value 'in_progress', 'Task is in progress', value: 'in_progress'
    value 'completed', 'Task has been completed', value: 'completed'
  end
end
