class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :task

  after_create :trigger_notification_added

  def trigger_notification_added
    TaskProApiSchema.subscriptions.trigger("notificationAdded", {}, self, scope: user)
  end
end
