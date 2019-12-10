class Founder < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user

  validates :company, presence: true, length: { minimum: 1 }
  validates :website, presence: true, length: { minimum: 2 }
  validates :github, presence: true, length: { minimum: 2 }
end
