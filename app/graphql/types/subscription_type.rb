# frozen_string_literal: true

module Types
  class SubscriptionType < Types::BaseObject
    description "The subscription root for the GraphQL schema"

    field :notification_added, subscription: Subscriptions::NotificationAdded
  end
end