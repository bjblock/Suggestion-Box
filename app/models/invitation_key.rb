class InvitationKey < ActiveRecord::Base
  
  belongs_to :suggestion_box
  
  validates :key, :presence => true, :length => {:within => 6..12}  

end
