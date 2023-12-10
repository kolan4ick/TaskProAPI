# frozen_string_literal: true

module Types
  class BoardType < Types::BaseObject
    field :id, ID, null: false
    field :project_id, Integer, null: false
    field :title, String
    field :description, String
    field :rosters, [Types::RosterType], null: true
    field :cover_photo, String, null: true
    field :position, Integer, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    def cover_photo
      return unless object.cover_photo.attached?

      Rails.application.routes.url_helpers.rails_blob_url(object.cover_photo.variant(resize_to_limit: [1000, 1000]), host: ENV['HOST'])
    end

    def rosters
      object.rosters.order(position: :asc)
    end
  end
end
