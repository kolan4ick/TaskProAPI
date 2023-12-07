# frozen_string_literal: true

module Types
  class ProjectType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :description, String
    field :boards, [Types::BoardType], null: true
    field :icon, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def icon
      return unless object.icon.attached?

      if object.icon.content_type == 'image/svg+xml'
        encoded_svg = Base64.strict_encode64(object.icon.download)
        "data:image/svg+xml;base64,#{encoded_svg}"
      else
        Rails.application.routes.url_helpers.rails_blob_url(object.icon, host: ENV['HOST'])
      end
    end

    def boards
      object.boards.order(position: :asc)
    end
  end
end
