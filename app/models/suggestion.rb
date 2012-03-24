class Suggestion < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :suggestion_box
  has_many :votes
  
  validates_presence_of :name
  validates_presence_of :description
  
end
