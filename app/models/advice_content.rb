class AdviceContent < ApplicationRecord
  belongs_to :advice

  mount_uploader :img, S3Uploader
end
