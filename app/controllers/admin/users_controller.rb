class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_index_path
    end
  end

  def favorite
    @events = current_user.favorited_events
  end

 private
  def user_params
    params.require(:user).permit(
      :prefecture_id, :last_name, :first_name, :group, :gender, :email,
      :phone_number, :postal_code, :address, :birthday, :encrypted_password, :is_deleted, category_ids: []
      )
  end
end
