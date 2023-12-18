# frozen_string_literal: true

module Mutations
  module Comments
    class CreateComment < BaseMutation
      field :comment, Types::CommentType, null: false

      argument :content, String, required: true
      argument :task_id, ID, required: true

      def resolve(**comment_input)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        user = context[:current_user]

        comment = user.comments.build(comment_input)

        raise GraphQL::ExecutionError, comment.errors.full_messages.join(', ') unless comment.save

        notification_content_uk = "Вам залишили коментар до завдання: #{comment.task.title}"
        notification_content_en = "A comment has been left on your task: #{comment.task.title}"
        user.notifications.build.create!(user_id: comment.task.assignee_id, content_uk: notification_content_uk, content_en: notification_content_en, task: comment.task)

        { comment: }
      end
    end
  end
end
