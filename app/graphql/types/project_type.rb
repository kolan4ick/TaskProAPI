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
      if object.icon.attached?
        Rails.application.routes.url_helpers.rails_blob_url(object.icon, host: ENV['HOST'])
      else
        nil
      end
    end
  end
end
