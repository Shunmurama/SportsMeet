class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
   if @user.update(user_params)
     redirect_to user_mypage_path
   end
  end

  def create
    @user = current_user.new(user_params)
    if @user.save
      @user.categories << Category.where(id: params[:user][:user_interest_id])
      redirect_to user_mypage_path
    end
  end

 private
  def user_params
    params.require(:user).permit(
      :prefecture_id, :user_interest_id, :favorite_id, :comment_id, :last_name, :first_name, :group, :email,
      :phone_number, :postal_code, :address, :birthday, :encrypted_password, :is_deleted,
      )
  end
end
