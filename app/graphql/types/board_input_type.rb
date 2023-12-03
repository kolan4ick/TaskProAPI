# frozen_string_literal: true

module Types
  class BoardInputType < Types::BaseInputObject
    argument :id, ID, required: false
    argument :project_id, Integer, required: false
    argument :title, String, required: false
    argument :description, String, required: false
    argument :rosters_arguments, [Types::RosterInputType], required: false
    argument :cover_photo, ApolloUploadServer::Upload, required: false
  end
end
