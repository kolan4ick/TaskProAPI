class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :task

  after_create :trigger_notifications_changed
  after_update :trigger_notifications_changed

  def trigger_notifications_changed
    notifications = user.notifications
    TaskProApiSchema.subscriptions.trigger("notifications_changed", {}, { notifications: })
  end
end
