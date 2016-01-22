class Result < ActiveRecord::Base
  def self.of_ok;              Constants::Result::ID_OK            end
  def self.of_ng;              Constants::Result::ID_NG            end
  def self.of_unknown;         Constants::Result::ID_UNKNOWN       end
  def self.of_preinitiation;   Constants::Result::ID_PREINITIATION end
end
