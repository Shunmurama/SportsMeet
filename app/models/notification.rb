class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum read:{
    unread: false, #未読
    read: true #既読
  }

end
