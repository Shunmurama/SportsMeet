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

  accepts_nested_attributes_for :event_categories, allow_destroy: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def available_numbers
    number - reservations.sum(:reserved_number)
  end
  
  def self.search(keyword, start_date, category_id)
    events = Event.all
    events = events.where("name LIKE ? OR outline LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword.present?
    events = events.where("date >= ?", start_date) if start_date.present?
    events = events.where(category_id: category_id) if category_id.present?
    events = [] if keyword.empty? && start_date.empty? && category_id.empty
    return events
  end
  
end