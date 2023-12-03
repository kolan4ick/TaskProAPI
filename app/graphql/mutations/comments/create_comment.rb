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

        # TODO: Create a notification for the task owner and assignee

        { comment: }
      end
    end
  end
end
