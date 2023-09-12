class Event < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :event_categories
  has_many :categories, through: :event_categories
  belongs_to :user
  has_one :prefecture

  has_one_attached :image

  enum how_to_pay: { local_pay: 0, transfer: 1 }
end
