class ProfilePicture < ApplicationRecord
  has_many :users

  enum color: { blue: 0, green: 1, yellow: 2 }
end
