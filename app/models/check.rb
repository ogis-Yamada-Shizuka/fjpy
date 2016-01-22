class Check < ActiveRecord::Base
  belongs_to :weather
  belongs_to :kiroku 
  belongs_to :exterior , :class_name => "Checkresult" , :foreign_key => "exterior_id"
  belongs_to :tone     , :class_name => "Checkresult" , :foreign_key => "tone_id"
  belongs_to :stain    , :class_name => "Checkresult" , :foreign_key => "stain_id"

  include Common
  after_commit :dump 
end
