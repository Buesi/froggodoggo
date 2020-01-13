class Contact < ApplicationRecord
  belongs_to :founder
  belongs_to :company
  enum hire_status: { interested: 0, hired: 1, declined: 2 }
end
