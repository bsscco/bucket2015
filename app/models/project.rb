class Project < ApplicationRecord
  belongs_to :user
  has_many :project_cards, :dependent => :destroy
  has_many :cards, through: :project_cards
  accepts_nested_attributes_for :project_cards, allow_destroy: true
end
