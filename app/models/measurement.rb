class Measurement < ActiveRecord::Base
  belongs_to :inspection_result 

  include Common
  after_commit :dump 
end
