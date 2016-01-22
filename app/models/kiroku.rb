class Kiroku < ActiveRecord::Base
  belongs_to :worker
  belongs_to :inspection
  has_one :check
  has_one :measurement
  has_one :note

  accepts_nested_attributes_for :measurement, :check, :note

  include Common
  after_commit :dump 
end
