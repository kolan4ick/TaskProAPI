# frozen_string_literal: true

module Types
  class TaskPriorityLevelType < Types::BaseEnum
    description "Task priority level enum"

    value :low, 'Low priority', value: 0
    value :medium, 'Medium priority', value: 1
    value :high, 'High priority', value: 2
  end
end
