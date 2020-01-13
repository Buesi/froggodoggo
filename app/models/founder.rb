class Founder < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  has_many :contacts
  has_one :unreviewed_founder_entry
  has_many :tech_breakdowns
  accepts_nested_attributes_for :tech_breakdowns

  enum days_per_week: [ :one, :two, :three, :four, :five ], _suffix: true
  enum duration: [ :one, :twotothree, :fourtosix, :seventotwelve, :overtwelve  ], _suffix: true
  enum specialisation: { fullstack: 0, frontend: 1, backend: 2, UXUI: 3, QA: 4 }

 
  DAYS_PER_WEEK_FORMATTED = {
    'one' => '1 day per week',
    'two' => '2 days per week',
    'three' => '3 days per week',
    'four' => '4 days per week',
    'five' => '5 days per week'      
  }    

  def days_per_week_formatted
    return DAYS_PER_WEEK_FORMATTED[days_per_week]
  end

  DURATION_FORMATTED = {
    'one' => '1 month',
    'twotothree' => '2 - 3 months',
    'fourtosix' => '4 - 6 months',
    'seventotwelve' => '7 - 12 months',
    'overtwelve' => 'more than 12 months'      
  }    

  def duration_formatted
    return DURATION_FORMATTED[duration]
  end

  SPECIALISATION_FORMATTED = {
    'fullstack' => 'full-stack',
    'frontend' => 'front-end',
    'backend' => 'back-end',
    'UXUI' => 'UX / UI',
    'QA' => 'QA'      
  }    

  def specialisation_formatted
    return SPECIALISATION_FORMATTED[specialisation]
  end


#### maybe do this later if people don't fill in everything
  # validates :company, presence: true, length: { minimum: 1 } 
end
