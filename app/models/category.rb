class Category < ApplicationRecord
  has_many :user_interests, dependent: :destroy
  has_many :users, through: :user_interests
  has_many :event_categories, dependent: :destroy
  has_many :events, through: :event_categories

  validates :name, presence: true

end
