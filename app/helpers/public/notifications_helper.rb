module Public::NotificationsHelper
  def unread_notifications
    @notifications = current_user.notifications.where(read: false)
  end
end
