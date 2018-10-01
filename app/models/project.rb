class Project < ApplicationRecord
  belongs_to :user
  has_many :project_cards, :dependent => :destroy
  has_many :cards, through: :project_cards
  accepts_nested_attributes_for :project_cards, allow_destroy: true
end

# Project DB에 대해서
# 의도: 집들이 - 연결고리 - 사진
# 집들이 삭제시 집들이 본체, 연결고리 삭제, 사진은 일반 사진으로 변경됨
# 이것이 맞는거죠?

# 약간 이렇게 되면 사용성에 불편함이 있을것 같습니다.
# 잘못올린 사진에 대해서 삭제를 했는데 어딘가에는 지속적으로 노출되는 현상이 발생할 것 같아요.
# 실질적으로 UPDATE 내용을 봐도 링크만 삭제하지, 사진을 삭제하지는 않고있내요.
# Advice에서도 언급했지만, Model 에서 관계를 설정해주는 것은 컨트롤러의 기능 강화 및 코드 줄임에 있습니다.

# accepts_nested_attributes_for :project_cards, allow_destroy: true
# 위 관계를 설정해두셨지만, 이 관계를 활용하는 부분이 어디에도 없습니다. (controller 포함)
# strong parameter(링크는 AdviceController쪽에)를 공부하시고 모든 컨트롤러에서의 creaet, update 문을 수정할 필요가 있습니다.
