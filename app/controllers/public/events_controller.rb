class Public::EventsController < ApplicationController

  def new
    @event = Event.new
    @event.event_categories.build
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      @event.create_notification_event!(@event.id)
      flash[:notice] = "イベントを投稿しました。"
      redirect_to events_path
    else
      @event.event_categories.build
      flash.now[:alert] = "必須項目を入力してください。"
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = "イベントが編集されました。"
      redirect_to event_path(@event.id)
    else
      flash.now[:alert] = "必須項目を入力してください。"
      render :edit
    end
  end

  def index
    @events = Event.all
    @events_run = @events.where('date >= ?', Date.today)
    @events_past = @events.where('date < ?', Date.today)
  end

  def show
    @event = Event.find(params[:id])
    @comment = Comment.new
    if user_signed_in?
      @reservation = current_user.reservations.where(event_id: @event.id)
    end
  end

  def result
    @keyword = params[:keyword]
    @start_date = params[:start_date]
    @category_ids = params[:category_ids]
    @category_ids.delete("")
    @prefecture = params[:prefecture]

    @events = Event.search(@keyword, @start_date, @category_ids, @prefecture)
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    flash[:alert] = "イベントを削除しました。"
    redirect_to events_path
  end

  private
    def event_params
      params.require(:event).permit(:user_id, :prefecture_id, :name, :image, :outline,
      :number, :minimum_number, :fixed_number, :date, :time, :place, :fee, :how_to_pay, :latitude, :longitude,
      category_ids: []
      )
    end

end
