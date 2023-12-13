# frozen_string_literal: true

module Types
  class TaskStatusType < Types::BaseEnum
    description "Task status enum"

    value "not_started", 'Task has not been started', value: 0
    value "in_progress", 'Task is in progress', value: 1
    value "completed", 'Task has been completed', value: 2
  end
end
