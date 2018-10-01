class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, S3Uploader

  has_many :cards
  has_many :projects
  has_many :advices
  # 사용자가 삭죄될 경우 has_many 관계에 있는 애들을 어떻게 해줄지설정이 필요합니다. Null 또는 삭제
end
