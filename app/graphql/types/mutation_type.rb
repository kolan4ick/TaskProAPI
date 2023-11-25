# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :users_update, mutation: Mutations::Users::UpdateUser
    field :sign_up, mutation: Mutations::Users::SignUpUser
    field :sign_in, mutation: Mutations::Users::SignInUser
  end
end
