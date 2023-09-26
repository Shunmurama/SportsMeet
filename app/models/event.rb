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

  validates :name, presence: true
  validates :outline, presence: true
  validates :number, presence: true
  validates :date, presence: true
  validates :prefecture_id, presence: true
  validates :place, presence: true
  validates :fee, presence: true
  validates :how_to_pay, presence: true

  enum how_to_pay: { local_pay: 0, transfer: 1 }

  accepts_nested_attributes_for :event_categories, allow_destroy: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def available_numbers
    number - reservations.sum(:reserved_number)
  end

  def self.search(keyword, start_date, category_ids)
    events = Event.all
    events = events.where("name LIKE ? OR outline LIKE ?", "%#{keyword}%", "%#{keyword}%") if keyword.present?
    events = events.where("date >= ?", start_date) if start_date.present?
    events = events.where(category_id: category_ids) if category_ids.present?
    events = [] if keyword.blank? && start_date.blank? && category_ids.blank?
    return events
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end