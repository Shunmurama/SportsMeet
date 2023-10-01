class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  def number_met
    if event.number > reserved_number.count
      errors.add(:base, "最小予約人数に達していません。最低#{event.number}人必要です。")
    end
  end

end
