class Advice < ApplicationRecord
  belongs_to :user
  has_many :advice_contents, :dependent => :destroy
  accepts_nested_attributes_for :advice_contents, allow_destroy: true

  mount_uploader :cover, S3Uploader
end
