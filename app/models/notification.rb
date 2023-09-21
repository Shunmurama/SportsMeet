class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :event
  
  def create_and_send_notification()
    
  end
  
end
