class Search < ApplicationRecord
  belongs_to :user

  validates :search_criteria, presence: true
end
