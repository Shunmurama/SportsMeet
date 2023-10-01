class Public::NotificationsController < ApplicationController
  def create
    @category = params[:category_ids]

    users_to_notify = User.where(category_ids: @category)

    users_to_notify.each do |user|
      notification = user.notifications.build(
        event: @event,
        message: "新しいイベントが追加されました。"
        )
      notification.save
    end
  end

end
