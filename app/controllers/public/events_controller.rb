class Public::EventsController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.new
    @event.event_categories.build
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if @event.save
      @event.create_notification_event!(@event.id, current_user)
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
    if params[:cat]
      category = Category.find(params[:cat])
      @events = category.events.page(params[:page]).per(20)
    else
      @events = Event.page(params[:page]).per(20)
    end
    @events_run = @events.where('date >= ?', Date.today)
    @events_past = @events.where('date < ?', Date.today)
  end

  def title
    if params[:cat]
      category = Category.find(params[:cat])
      @events = category.events.page(params[:page]).per(20)
    else
      @events = Event.page(params[:page]).per(20)
    end
    @events_run = @events.where('date >= ?', Date.today)
    @events_past = @events.where('date < ?', Date.today)
  end

  def show
    @event = Event.find(params[:id])
    @comment = Comment.new
    if user_signed_in?
      @check = current_user.reservations.where(event_id: @event.id)
    end
    @reservation = current_user.reservations.where(event_id: @event.id).pluck(:id)
  end

  def result
    @keyword = params[:keyword]
    @start_date = params[:start_date]
    @category_ids = params[:category_ids]
    @category_ids.delete("")
    @prefecture = params[:prefecture]

    @events = Event.search(@keyword, @start_date, @category_ids, @prefecture)
    @events_run = @events.where('date >= ?', Date.today)
    @events_past = @events.where('date < ?', Date.today)
  end

  def destroy
    event = Event.find(params[:id])
    notification_to_delete = @event.reservations
    notification_to_delete.destroy_all
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

    def is_matching_edit_user
      event = Event.find(params[:id])
      unless event.user_id == current_user.id
        redirect_to user_mypage_path
      end
    end

end
