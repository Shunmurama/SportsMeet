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
      if @event.fixed_number.present?
        if reserved_number <= @event.available_numbers && reserved_number == @event.fixed_number
          @reservation.date = @event.date
          if @reservation.save
            redirect_to user_mypage_path, notice: '予約しました'
          end
        else
          flash.now[:alert] = '予約人数を確認してください。'
          render :new
        end
      else
        if reserved_number <= @event.available_numbers && reserved_number >= @event.minimum_number
          @reservation.date = @event.date
          if @reservation.save
            redirect_to user_mypage_path, notice: '予約しました'
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

    if @event.fixed_number.present?
      if reserved_number <= @event.available_numbers && reserved_number == @event.fixed_number
        @reservation.update(reservation_params)
        redirect_to event_reservation_path
      else
        flash.now[:alert] = '予約人数を確認してください。'
        render :edit
      end
    else
      if reserved_number <= @event.available_numbers && reserved_number >= @event.minimum_number
        @reservation.update(reservation_params)
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
    redirect_to user_reserved_path, notice: '予約を取り消しました'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:event_id, :user_id, :reserved_number, :date)
  end

end