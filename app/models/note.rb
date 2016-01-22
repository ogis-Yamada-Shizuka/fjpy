class Note < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  belongs_to :kiroku 

  include Common
  after_commit :dump 
end
