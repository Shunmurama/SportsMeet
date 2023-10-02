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
      if reserved_number <= @event.available_numbers
        @reservation.date = @event.date
        if @reservation.save
          redirect_to user_mypage_path, notice: '予約しました'
        end
      else
        flash[:alert] = '予約可能な人数を超えています。'
        render :new
      end
    else
      flash[:alert] = '既にこのイベントは終了しています。'
      render :new
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