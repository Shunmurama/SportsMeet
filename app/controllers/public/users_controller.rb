class Public::UsersController < ApplicationController

  def show
    @user = current_user
    @users = User.all
    @notifications = current_user.notifications
    @notifications.where(read: '0').each do |notification|
      notification.update_attributes(read: '1')
    end
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

 private

  def user_params
    params.require(:user).permit(
      :prefecture_id, :last_name, :first_name, :image, :group, :gender, :email,
      :phone_number, :postal_code, :address, :birthday, :encrypted_password, :is_deleted, category_ids: []
      )
  end

end
