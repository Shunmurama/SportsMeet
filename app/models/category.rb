class Category < ApplicationRecord
  has_many :user_interests, dependent: :destroy
  has_many :event_categories, dependent: :destroy
end
