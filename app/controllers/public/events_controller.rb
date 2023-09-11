class Public::EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to events_path
    end
  end

  def edit
    @event = Event.find(@arams[:id])
  end

  def update
    @event = Event.find(@arams[:id])
    if @event.update(event_params)
      redirect_to events_path
    end
  end

  def index
    @events = Event.all
  end

  private
    def event_params
      params.require(:event).permit(:user_id, :category_id, :prefecture_id, :name, :outline, :number, :date, :place, :fee, :how_to_pay)
    end
end
