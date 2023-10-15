class Public::ReservationsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new
  end

  def create
    @event = Event.find(params[:event_id])
    @reservation = current_user.reservations.build(reservation_params)
    reserved_number = params[:reservation][:reserved_number].to_i

    if @event.date >= Date.today
      @reservation.date = @event.date
      # 人数指定がある場合
      if @event.fixed_number.present?
        if reserved_number <= @event.available_numbers && reserved_number == @event.fixed_number
          if @reservation.save
            flash[:notice] = "予約しました。"
            redirect_to user_mypage_path
          end
        else
          flash.now[:alert] = '予約人数を確認してください。'
          render :new
        end
        # 最小の人数制限がある場合
      elsif @event.minimum_number.present?
        if reserved_number <= @event.available_numbers && reserved_number >= @event.minimum_number
          if @reservation.save
            flash[:notice] = "予約しました。"
            redirect_to user_mypage_path
          end
        else
          flash.now[:alert] = '予約人数を確認してください。'
          render :new
        end
        # 個人または代表者がまとめて予約する場合
      else
        if reserved_number <= @event.available_numbers
          if @reservation.save
            flash[:notice] = "予約しました。"
            redirect_to user_mypage_path
          end
        else
          flash.now[:alert] = '予約人数を確認してください。'
          render :new
        end
      end

    else
        flash.now[:alert] = '既にこのイベントは終了しています。'
        render :new
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @reservation = current_user.reservations.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @reservation = current_user.reservations.find(params[:id])
    reserved_number = params[:reservation][:reserved_number].to_i
    # 人数指定がある場合
    if @event.fixed_number.present?
      if reserved_number <= @event.available_numbers && reserved_number == @event.fixed_number
        @reservation.update(reservation_params)
        flash[:notice] = "予約内容を更新しました。"
        redirect_to event_reservation_path
      else
        flash.now[:alert] = '予約人数を確認してください。'
        render :edit
      end
    # 最小の人数制限がある場合
    elsif @event.minimum_number.present?
      if reserved_number <= @event.available_numbers && reserved_number >= @event.minimum_number
        @reservation.update(reservation_params)
        flash[:notice] = "予約内容を更新しました。"
        redirect_to event_reservation_path
      else
        flash.now[:alert] = '予約人数を確認してください。'
        render :edit
      end
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.find(params[:id])
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy
    flash.now[:alert] = '予約人数を確認してください。'
    redirect_to user_reserved_path
  end

  private

  def reservation_params
    params.require(:reservation).permit(:event_id, :user_id, :reserved_number, :date)
  end

end