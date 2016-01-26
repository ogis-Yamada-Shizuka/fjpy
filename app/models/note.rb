class Note < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  belongs_to :inspection_result 

  include Common
  after_commit :dump 
end
