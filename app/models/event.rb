class Event < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  belongs_to :prefecture
  belongs_to :event_category

  has_one_attached :image
end
