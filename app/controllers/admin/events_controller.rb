class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @events = Event.page(params[:page])
    @events_run = @events.where('date >= ?', Date.today)
    @events_past = @events.where('date < ?', Date.today)
  end

  def result
    @keyword = params[:keyword]
    @start_date = params[:start_date]
    @category_ids = params[:category_ids]
    @category_ids.delete("")
    @prefecture = params[:prefecture]

    @events = Event.search(@keyword, @start_date, @category_ids, @prefecture)
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    flash.now[:alert] = "イベントを削除しました。"
    redirect_to admin_events_path
  end

  private
    def event_params
      params.require(:event).permit(:user_id, :prefecture_id, :name, :image, :outline,
      :number, :minimum_number, :fixed_number, :date, :time, :place, :fee, :how_to_pay, :latitude, :longitude,
      category_ids: []
      )
    end

end
