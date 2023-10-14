class Public::FavoritesController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    favorite = current_user.favorites.new(event_id: event.id)
    favorite.save
    flash[:notice] = "お気に入りに登録しました。"
    redirect_to event_path(event)
  end

  def destroy
    event = Event.find(params[:event_id])
    favorite = current_user.favorites.find_by(event_id: event.id)
    favorite.destroy
    flash[:alert] = "お気に入りを削除しました。"
    redirect_to event_path(event)
  end

end
