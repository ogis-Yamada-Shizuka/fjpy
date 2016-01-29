class InspectionRequest < ActiveRecord::Base
  belongs_to :service
  belongs_to :inspect_schedule
end
