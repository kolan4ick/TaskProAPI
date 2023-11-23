# frozen_string_literal: true

module Mutations
  module Users

    class SignUpUser < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :phone, String, required: true

      field :token, String, null: true
      field :user, Types::UserType, null: true

      def resolve(email:, password:, password_confirmation:, first_name:, last_name:, phone:)
        user = User.new(email: email, password: password, password_confirmation: password_confirmation, first_name: first_name, last_name: last_name, phone: phone)
        return unless user.save

        token = user.generate_jwt

        { token: token, user: user }
      end
    end
  end
end
