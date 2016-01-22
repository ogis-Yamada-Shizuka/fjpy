class Status < ActiveRecord::Base
  def self.of_unallocated;   Constants::Status::ID_UNALLOCATED end
  def self.of_ready;         Constants::Status::ID_READY       end
  def self.of_doing;         Constants::Status::ID_DOING       end
  def self.of_done;          Constants::Status::ID_DONE        end
end
