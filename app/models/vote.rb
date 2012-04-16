class Vote < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :suggestion

  after_save :update_total_votes_of_suggestion
  
  def update_total_votes_of_suggestion
    self.suggestion.update_attribute :total_votes, self.suggestion.votes.count
    self.suggestion.update_attribute :average_score, self.suggestion.votes.average(:score)
  end
      
end
