module Subscriptions
  class NotificationsChanged < GraphQL::Schema::Subscription
    description "Notifications changed"

    field :notification_ids, [ID], null: false
  end
end
