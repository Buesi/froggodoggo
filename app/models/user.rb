class User < ApplicationRecord
  has_one :founder

  validates :name, presence: true, length: { minimum: 2 }
  validates :surname, presence: true, length: { minimum: 2 }
  validates :email, presence: true, length: { minimum: 2 }
end
