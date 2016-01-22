class Measurement < ActiveRecord::Base
  belongs_to :kiroku 

  include Common
  after_commit :dump 
end
