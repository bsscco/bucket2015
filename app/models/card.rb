class Card < ApplicationRecord
  belongs_to :user
  has_many :project_cards
  has_many :projects, through: :project_cards

  mount_uploader :img, S3Uploader
end
