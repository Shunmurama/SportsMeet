class Event < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :event_categories, dependent: :destroy
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

   geocoded_by :place
   after_validation :geocode, if: :place_changed?

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def available_numbers
    number - reservations.sum(:reserved_number)
  end

  def self.search(keyword, start_date, category_ids, prefecture)
    events = Event.all

    if keyword.present?
      events = events.where("name LIKE ? OR outline LIKE ?", "%#{keyword}%", "%#{keyword}%")
    end
    if start_date.present?
      events = events.where("date >= ?", start_date)
    end
    if prefecture.present? && prefecture != "0"
      events = events.where(prefecture_id: prefecture)
    end
    if category_ids.present?
      event_ids = EventCategory.where(category_id: category_ids).pluck(:event_id)
      events = events.where(id: event_ids)
    end

    events = events.order(date: :asc)

    return events
  end


  def create_notification_event!(event_id)
    categories.each do |category|
        user_ids = UserInterest.where(category_id: category_ids).pluck(:user_id)
        users = User.where(id: user_ids)
        users.each do |user|
          save_notification_event!(event_id, user.id)
        end
    end
  end

  def save_notification_event!(event_id, user_id)
      notification = Notification.new(
        user_id: user_id,
        event_id: event_id,
        read: false
      )
      notification.save
  end


  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end