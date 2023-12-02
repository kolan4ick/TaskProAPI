# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Comments
    field :delete_comment, mutation: Mutations::Comments::DeleteComment
    field :create_comment, mutation: Mutations::Comments::CreateComment

    # Tasks
    field :delete_task, mutation: Mutations::Tasks::DeleteTask
    field :update_task, mutation: Mutations::Tasks::UpdateTask
    field :create_task, mutation: Mutations::Tasks::CreateTask

    # Rosters
    field :delete_roster, mutation: Mutations::Rosters::DeleteRoster
    field :update_roster, mutation: Mutations::Rosters::UpdateRoster
    field :create_roster, mutation: Mutations::Rosters::CreateRoster

    # Boards
    field :delete_board, mutation: Mutations::Boards::DeleteBoard
    field :update_board, mutation: Mutations::Boards::UpdateBoard
    field :create_board, mutation: Mutations::Boards::CreateBoard

    # Projects
    field :delete_project, mutation: Mutations::Projects::DeleteProject
    field :update_project, mutation: Mutations::Projects::UpdateProject
    field :create_project, mutation: Mutations::Projects::CreateProject

    # Users
    field :users_update, mutation: Mutations::Users::UpdateUser
    field :sign_up, mutation: Mutations::Users::SignUpUser
    field :sign_in, mutation: Mutations::Users::SignInUser
  end
end
