class InvitationKey < ActiveRecord::Base
  
  belongs_to :suggestion_box
  
end
