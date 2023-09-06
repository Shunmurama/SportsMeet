class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :prefecture
  belongs_to :user_interest
end
