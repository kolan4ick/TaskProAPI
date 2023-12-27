class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :task

  after_create :trigger_notifications_changed
  after_update :trigger_notifications_changed

  def trigger_notifications_changed
    notification_ids = user.notifications.pluck(:id)
    TaskProApiSchema.subscriptions.trigger("notificationsChanged", {}, notification_ids)
  end
end
