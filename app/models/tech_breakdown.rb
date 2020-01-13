class TechBreakdown < ApplicationRecord
  belongs_to :founder

  accepts_nested_attributes_for :founder #is this even necessary??? think only needed in foudner model

  enum proficiency: { low: 0, medium: 1, high: 2 }

end
