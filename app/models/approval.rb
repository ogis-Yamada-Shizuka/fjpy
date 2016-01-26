class Approval < ActiveRecord::Base
  belongs_to :inspection_schedule
end
