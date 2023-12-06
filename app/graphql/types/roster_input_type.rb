# frozen_string_literal: true

module Types
  class RosterInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :board_id, Integer, required: false
    argument :title, String, required: false
    argument :tasks_arguments, [Types::TaskInputType], required: false
    argument :position, Integer, required: false
  end
end
