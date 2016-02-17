class ResultStatus < ActiveRecord::Base
  class << self
    Constants::ResultStatus.constants.each_with_index do |id, i|
      define_method "of_#{id.to_s.sub(/ID_/, '').downcase}" do
        Constants::ResultStatus.constants[i]
      end
    end
  end
end
