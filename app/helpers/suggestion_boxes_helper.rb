module SuggestionBoxesHelper
  
  def average_rating(suggestion)
    number_with_precision(suggestion.votes.average(:score), :precision => 2)
  end
  
end
