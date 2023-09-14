class Public::EventsController < ApplicationController
  def new
    @event = Event.new
    @event.event_categories.build
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      redirect_to events_path
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to events_path
    end
  end

  def index
    @events = Event.all
  end

  def search
    @keyword = params[:keyword]
    @start_date = params[:start_date]
    @category_id = params[:category_ids]

    @events = Event.search(@keywrod, @start_date, @category_id)
  end

  def result
    @keyword = params[:keyword]
    @start_date = params[:start_date]
    @category_id = params[:category_ids]

    @events = Event.search(@keyword, @start_date, @category_id)
  end

  private
    def event_params
      params.require(:event).permit(:user_id, :prefecture_id, :name,
      :outline, :number, :date, :place, :fee, :how_to_pay,
      category_ids: []
      )
    end
end
