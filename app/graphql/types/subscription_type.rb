# frozen_string_literal: true

module Types
  class SubscriptionType < Types::BaseObject
    description "The subscription root for the GraphQL schema"

    field :notifications_changed, subscription: Subscriptions::NotificationsChanged
  end
end