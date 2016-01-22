class Topic < ActiveRecord::Base
  belongs_to :flag
  has_many :comments
end
