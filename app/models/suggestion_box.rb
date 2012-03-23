class SuggestionBox < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :organization
  has_many :suggestions
  has_many :votes, :through => :suggestions

  validates_presence_of :title
  validates_presence_of :description
  validates_inclusion_of :by_invite_only, :in => [true, false]
  validates_inclusion_of :votable, :in => [true, false]
  validates_inclusion_of :anonymous_suggestions, :in => [true, false]
  
end
