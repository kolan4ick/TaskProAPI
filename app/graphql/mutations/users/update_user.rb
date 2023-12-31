# frozen_string_literal: true

module Mutations
  module Users

    class UpdateUser < BaseMutation
      argument :email, String, required: false
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :phone, String, required: false

      field :user, Types::UserType, null: true
      field :errors, [String], null: false

      def resolve(email:, password:, password_confirmation:, first_name:, last_name:, phone:)
        raise GraphQL::ExecutionError, "You need to authenticate to perform this action" if context[:current_user].nil?

        user = context[:current_user]

        if user.update(email: email, password: password, password_confirmation: password_confirmation, first_name: first_name, last_name: last_name, phone: phone)
          {
            user: user,
            errors: []
          }
        else
          {
            user: nil,
            errors: user.errors.full_messages
          }
        end
      end
    end
  end
end
