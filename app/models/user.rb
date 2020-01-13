class User < ApplicationRecord
  has_one :founder
  has_one :company
  
  belongs_to :profile_picture
  accepts_nested_attributes_for :profile_picture

end
