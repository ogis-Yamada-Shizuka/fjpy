class ResultStatus < ActiveRecord::Base
  def self.of_ok
    Constants::ResultStatus::ID_OK
  end

  def self.of_ng
    Constants::ResultStatus::ID_NG
  end

  def self.of_unknown
    Constants::ResultStatus::ID_UNKNOWN
  end

  def self.of_preinitiation
    Constants::ResultStatus::ID_PREINITIATION
  end
end
