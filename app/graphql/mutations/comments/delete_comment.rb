# frozen_string_literal: true

module Mutations
  module Comments
    class DeleteComment < BaseMutation
      field :comment, Types::CommentType, null: false

      argument :id, ID, required: true

      def resolve(id:)
        raise GraphQL::ExecutionError, 'Unauthorized' unless context[:current_user].present?

        comment = Comment.find(id)

        raise GraphQL::ExecutionError, 'Unauthorized' unless comment.user_id == context[:current_user].id

        comment.destroy

        { comment: }
      end
    end
  end
end
