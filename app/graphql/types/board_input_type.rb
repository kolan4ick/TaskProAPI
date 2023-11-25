# frozen_string_literal: true

module Types
  class BoardInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :project_id, Integer, required: false
    argument :title, String, required: false
    argument :description, String, required: false
    argument :rosters_arguments, [Types::RosterInputType], required: false
    argument :created_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :updated_at, GraphQL::Types::ISO8601DateTime, required: false
  end
end
