# frozen_string_literal: true

module Mutations
  module Users
    class CheckTokenUser < BaseMutation
      argument :token, String, required: true

      field :user, Types::UserType, null: true
      field :token, String, null: true

      def resolve(token:)

        decoded_token = JWT.decode(token, Rails.application.credentials.dig(Rails.env.to_sym, :secret_key_base), true, { algorithm: 'HS256' })

        user = User.find(decoded_token[0]['id'])

        raise GraphQL::ExecutionError, 'Invalid token' unless user.present?

        user.update!(last_sign_in_at: Time.now)

        { user:, token: }
      rescue StandardError => e
        raise GraphQL::ExecutionError, "An error occurred: #{e.message}"

      end
    end
  end
end
