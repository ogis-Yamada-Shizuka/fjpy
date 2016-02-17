class ScheduleStatus < ActiveRecord::Base
  class << self
    Constants::ScheduleStatus.constants.each_with_index do |id, i|
      define_method "of_#{id.to_s.sub(/ID_/, '').downcase}" do
        const_get("Constants::ScheduleStatus::#{Constants::ScheduleStatus.constants[i].to_s}")
      end
    end
  end
end
