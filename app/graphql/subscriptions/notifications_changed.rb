module Subscriptions
  class NotificationsChanged < BaseSubscription
    description "Notifications changed"

    field :notifications, [Types::NotificationType], null: false
  end
end