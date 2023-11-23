# frozen_string_literal: true

module Mutations
  module Users
    class SignInUser < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :token, String, null: true
      field :user, Types::UserType, null: true

      def resolve(email:, password:)
        # return user if already signed in
        if context[:current_user].present?
          user = context[:current_user]
          token = user&.generate_jwt

          context[:session][:token] = token

          return { user:, token: }
        end

        GraphQL::ExecutionError.new('Please provide an email and password') if email.blank? || password.blank?

        user = ::User.find_for_authentication(email:)

        if user&.valid_password?(password)
          token = user.generate_jwt
          context[:session][:token] = token
          { token:, user: }
        else
          GraphQL::ExecutionError.new('Invalid email or password')
        end
      end
    end
  end
end
