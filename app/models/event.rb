class Event < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :event_categories
  has_many :categories, through: :event_categories
  belongs_to :user
  belongs_to :prefecture


  has_one_attached :image
end
