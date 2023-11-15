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
      # 空欄と０の場合登録できないようにする
      if !@reservation.reserved_number.nil? && @reservation.reserved_number != 0
        # 人数指定がある場合
        if @event.fixed_number.present?
          if reserved_number <= @event.available_numbers && reserved_number == @event.fixed_number
            @reservation.save
            flash[:notice] = "予約しました。"
            redirect_to user_mypage_path
          else
            flash.now[:alert] = '予約人数を確認してください。'
            render :new
          end
          # 最小の人数制限がある場合
        elsif @event.minimum_number.present?
          if reserved_number <= @event.available_numbers && reserved_number >= @event.minimum_number
            @reservation.save
            flash[:notice] = "予約しました。"
            redirect_to user_mypage_path
          else
            flash.now[:alert] = '予約人数を確認してください。'
            render :new
          end
          # 個人が、または代表者がまとめて予約する場合
        else
          if reserved_number <= @event.available_numbers
            @reservation.save
            flash[:notice] = "予約しました。"
            redirect_to user_mypage_path
          else
            flash.now[:alert] = '予約人数を確認してください。'
            render :new
          end
        end

      # 人数がしっかり入力されていない場合
      else
        flash.now[:alert] = '予約人数を入力してください。'
        render :new
      end

      # 日付が過ぎている場合
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
      # 予約人数をリセット

    # 空欄と０の場合登録できないようにする
    if !@reservation.reserved_number.nil? && @reservation.reserved_number != 0
      # 最小の人数制限がある場合
      if @event.minimum_number.present?
        if @event.number >= reserved_number && reserved_number >= @event.minimum_number
          @reservation.update(reservation_params)

          flash[:notice] = "予約内容を更新しました。"
          redirect_to event_reservation_path(@event.id, @reservation.id)
        else
          flash.now[:alert] = '予約人数を確認してください。2'
          render :edit
        end
      # 個人が、または代表者が編集する場合
      else
        if @event.number >= reserved_number
          @reservation.update(reservation_params)

          flash[:notice] = "予約内容を更新しました。"
          redirect_to event_reservation_path(@event.id, @reservation.id)
        else
            flash.now[:alert] = '予約人数を確認してください。3'
            render :edit
        end
      end

    else
        flash.now[:alert] = '予約人数を入力してください。'
        render :edit
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @reservation = current_user.reservations.find(params[:id])
    # @reservation = @event.reservations.find_by(event_id: params[:event_id])
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