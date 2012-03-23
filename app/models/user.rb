class User < ActiveRecord::Base
  
  has_secure_password

  has_many :suggestion_boxes
  has_many :suggestions
  has_many :votes

  validates :name, :presence => true
  validates :email, :presence => true
  
end
