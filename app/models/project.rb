class Project < ApplicationRecord
  belongs_to :user
  has_many :project_cards
  has_many :cards, through: :project_cards
  accepts_nested_attributes_for :project_cards
end
