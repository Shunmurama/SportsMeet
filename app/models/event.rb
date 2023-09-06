class Event < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :prefecture
  belongs_to :event_category
end
