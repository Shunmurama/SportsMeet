class Public::UsersController < ApplicationController

  def show
    @user = current_user
    @users = User.all
    @notifications = Notification.joins(:event)
                                .where(user_id: @user.id, read: "unread")
                                .where("events.date >= ?", Date.today)
  end

  def edit
    @user = current_user
    @user.user_interests.build
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "登録情報を更新しました。"
      redirect_to user_mypage_path
    else
      flash.now[:alert] = "必須項目を入力してください。"
      render :edit
    end
  end

  def favorite
    @user_favorites = current_user.favorites
    @event_run = @user_favorites.joins(:event).where("events.date >= ?", Date.today)
    @event_past = @user_favorites.joins(:event).where("events.date < ?", Date.today)
  end

  def reserved
    @user_reserved = current_user.reservations
    @event_run = @user_reserved.joins(:event).where("events.date >= ?", Date.today)
    @event_past = @user_reserved.joins(:event).where("events.date < ?", Date.today)
  end

  def unsubscribe
    @user = current_user
  end

  def withdrawal
    @user = current_user
    reservations_to_delete = @user.reservations
    reservations_to_delete.destroy_all
    events_to_delete = @user.events
    events_to_delete.destroy_all
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def notification
    @notifications = Notification.where(user_id: current_user.id)

    respond_to do |format|
      format.html
      format.js
    end

    def notification_read
      notification = Notification.find(params[:id])
      redirect_to root_path and return unless notification.user_id == current_user.id
      notification.update(read: "read")
      redirect_to user_mypage_path
    end
  end



 private

  def user_params
    params.require(:user).permit(
      :prefecture_id, :last_name, :first_name, :image, :group, :gender, :email,
      :phone_number, :postal_code, :address, :birthday, :encrypted_password, :is_deleted, category_ids: []
      )
  end

end
