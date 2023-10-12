class Public::UsersController < ApplicationController

  def show
    @user = current_user
    @users = User.all
    @notifications = Notification.where(user_id: @user.id)
  end

  def edit
    @user = current_user
    @user.user_interests.build
  end

  def update
    @user = current_user
   if @user.update(user_params)
     redirect_to user_mypage_path
   end
  end

  def favorite
    @user_favorites = current_user.favorites
  end

  def reserved
    @user_reserved = current_user.reservations
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
    flash[:notice] = "退会しました。"
    redirect_to root_path
  end

  def notification
    @notifications = Notification.where(user_id: current_user.id)

    respond_to do |format|
      format.html
      format.js # js形式で送信された場合はこちらが適応され、js.erbを探す
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
