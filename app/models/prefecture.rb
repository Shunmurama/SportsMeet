class Prefecture < ApplicationRecord
  has_many :municipalities, dependent: :destroy
end
