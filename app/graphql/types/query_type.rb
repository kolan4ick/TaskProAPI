# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { | id | context.schema.object_from_id(id, context) }
    end

    field :projects, [Types::ProjectType], null: false, description: "Returns a list of projects" do
      argument :limit, Integer, required: false, default_value: 10, description: "Number of projects to return"
    end

    def projects(limit:)
      raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

      Project.limit(limit)
    end

    field :boards, [Types::BoardType], null: false, description: "Returns a list of boards" do
      argument :limit, Integer, required: false, default_value: 10, description: "Number of boards to return"
    end

    def boards(limit:)
      raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

      Board.limit(limit)
    end

    field :rosters, [Types::RosterType], null: false, description: "Returns a list of rosters" do
      argument :limit, Integer, required: false, default_value: 10, description: "Number of rosters to return"
    end

    def rosters(limit:)
      raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

      Roster.limit(limit)
    end
  end
end
