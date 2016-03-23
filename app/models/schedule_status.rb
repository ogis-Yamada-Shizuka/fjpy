class ScheduleStatus < ActiveRecord::Base
  include Constants::ScheduleStatus

  scope :inspection_target, -> { where(id: [ID_DATES_CONFIRMED, ID_IN_PROGRESS]) }
  scope :done, -> { where(id: [ID_APPROVED, ID_COMPLETED]) }
  scope :not_done, -> { where.not(id: [ID_APPROVED, ID_COMPLETED]) }

  class << self
    Constants::ScheduleStatus.constants.each_with_index do |id, i|
      define_method "of_#{id.to_s.sub(/ID_/, '').downcase}" do
        const_get("Constants::ScheduleStatus::#{Constants::ScheduleStatus.constants[i]}")
      end
    end

    delegate :ids, to: :inspection_target, prefix: true

    delegate :ids, to: :done, prefix: true

    delegate :ids, to: :not_done, prefix: true
  end
end
