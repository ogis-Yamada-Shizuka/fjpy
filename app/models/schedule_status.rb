class ScheduleStatus < ActiveRecord::Base
  scope :not_done, -> { where.not(id: Constants::ScheduleStatus::ID_COMPLETED) }

  class << self
    Constants::ScheduleStatus.constants.each_with_index do |id, i|
      define_method "of_#{id.to_s.sub(/ID_/, '').downcase}" do
        const_get("Constants::ScheduleStatus::#{Constants::ScheduleStatus.constants[i].to_s}")
      end
    end

    def not_done_ids
      not_done.ids
    end
  end
end
