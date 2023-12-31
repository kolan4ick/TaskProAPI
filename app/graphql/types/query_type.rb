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

    field :project, Types::ProjectType, null: false, description: "Returns a project" do
      argument :id, ID, required: true, description: "ID of the project"
    end

    def project(id:)
      raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

      Project.find(id)
    end

    field :board, Types::BoardType, null: false, description: "Returns a board" do
      argument :id, ID, required: true, description: "ID of the board"
    end

    def board(id:)
      raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

      Board.find(id)
    end

    field :users, [Types::UserType], null: false, description: "Returns a list of users"

    def users
      raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

      User.all
    end

    field :recommend_tasks, [Types::TaskType], null: false, description: "Returns a list of tasks recommended for the current user"

    def recommend_tasks
      raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

      current_user = context[:current_user]

      tasks = current_user.assigned_tasks.where.not(status: :completed).order(:deadline, :priority_level)

      # Get the first 3 tasks from each project
      tasks.group_by { | task | task.roster.board.project_id }.map { | _, tasks | tasks.first(3) }.flatten
    end

    field :notifications, [Types::NotificationType], null: false, description: "Returns a list of notifications for the current user"

    def notifications
      raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

      current_user = context[:current_user]

      # Fetch all unread notifications
      unread_notifications = current_user.notifications.where(read: false).order(created_at: :desc)

      # Fetch last 10 read notifications
      last_read_notifications = current_user.notifications.where(read: true).order(created_at: :desc).limit(10)

      # Combine both sets into a single list
      unread_notifications + last_read_notifications
    end

    field :last_boards, [Types::BoardType], null: false, description: "Returns a list of boards that the current user has activity in"

    def last_boards
      raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

      current_user = context[:current_user]

      all_user_tasks = current_user.all_related_tasks

      # Fetch last 10 boards that the user has activity in
      all_user_tasks.map { | task | task.roster.board }.uniq.last(10)
    end
  end
end
