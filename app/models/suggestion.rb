class Suggestion < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :suggestion_box
  has_many :votes
  
end
