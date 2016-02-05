class InspectionResult < ActiveRecord::Base
  belongs_to :user
  belongs_to :inspection_schedule
  has_one :check
  has_one :measurement
  has_one :note
  has_one :approval

  accepts_nested_attributes_for :measurement, :check, :note

  include Common
  after_commit :dump
end
