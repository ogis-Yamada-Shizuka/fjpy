class ScheduleStatus < ActiveRecord::Base
  class << self
    Constants::ScheduleStatus.constants.each_with_index do |id, i|
      define_method "of_#{id.to_s.sub(/ID_/, '').downcase}" do
        Constants::ScheduleStatus.constants[i]
      end
    end
  end
end
