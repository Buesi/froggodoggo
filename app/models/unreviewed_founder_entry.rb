class UnreviewedFounderEntry < ApplicationRecord
  belongs_to :founder

  accepts_nested_attributes_for :founder

  enum review_status: { unreviewed: 0, accepted: 1, rejected: 2 }

end
