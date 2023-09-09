class Public::EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
  end

  private
    def event_params
      params.require(:event).permit(:user_id, :category_id, :prefecture_id, :name, :outline, :number, :date, :place, :fee, :how_to_pay)
    end
end
