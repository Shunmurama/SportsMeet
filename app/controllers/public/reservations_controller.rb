class Public::ReservationsController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = current_user.reservations.create(reservation_params)
    @reservation.user_id = current_user.id
    @event = Event.find(params[:event_id])
    @reservation.date = @event.date
    if @reservation.save
      redirect_to user_mypage_path, notice: '予約しました'
    else
      redirect_to events_path
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.find(params[:id])
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy
    redirect_to user_mypage_path, notice: '予約を取り消しました'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:event_id, :user_id, :reserved_number, :date)
  end

end