class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page])
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
      flash[:notice] = "ユーザーを編集しました。"
      redirect_to admin_user_path
    else
      flash.now[:alert] = "必要項目を入力してください。"
      render :edit
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdrawal
    @user = User.find(params[:id])
    reservations_to_delete = @user.reservations
    reservations_to_delete.destroy_all
    events_to_delete = @user.events
    events_to_delete.destroy_all
    @user.update(is_deleted: true)
    reset_session
    redirect_to admin_index
  end

 private
  def user_params
    params.require(:user).permit(
      :prefecture_id, :last_name, :first_name, :group, :gender, :email,
      :phone_number, :postal_code, :address, :birthday, :encrypted_password, :is_deleted, category_ids: []
      )
  end
end
