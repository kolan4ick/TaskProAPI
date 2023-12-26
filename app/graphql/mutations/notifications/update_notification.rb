module Mutations
  module Notifications
    class UpdateNotification < ::Mutations::BaseMutation
      argument :id, ID, required: true
      argument :read, Boolean, required: true

      type Types::NotificationType

      def resolve(id:, read:)
        notification = Notification.find(id)

        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?
        raise GraphQL::ExecutionError, 'You are not allowed to update this notification' unless context[:current_user] == notification.user

        notification.update(read: read)

        notification
      end
    end
  end
end