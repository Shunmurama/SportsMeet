class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :reserved_number, numericality: { greater_than: 0 }

  def number_met
    if event.number > reserved_number.count
      errors.add(:base, "最小予約人数に達していません。最低#{event.number}人必要です。")
    end
  end

end
