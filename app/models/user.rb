class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_events, through: :favorites, source: :event
  has_many :user_interests
  has_many :categories, through: :user_interests
  has_one :prefecture

  has_one_attached :image

  enum gender: {"--":0, 男性:1, 女性:2}

  accepts_nested_attributes_for :user_interests, allow_destroy: true
  
  def active_for_authentication?
    super && (is_deleted == false)
  end

  def full_name
    self.last_name + " " + self.first_name
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
