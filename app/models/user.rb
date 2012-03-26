class User < ActiveRecord::Base
  
  has_secure_password

  has_many :suggestion_boxes
  has_many :suggestions
  has_many :votes

  # validates_presence_of :name
  # validates_presence_of :email
  # validates_uniqueness_of :email
  # validates :email, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :on => :create }
  # validates :password, :presence => true,
                       # :confirmation => true,
                       # :length => {:within => 6..12}
  
end
