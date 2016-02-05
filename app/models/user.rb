class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :company

  # CSV Upload
  require "csv"
  def self.import(file)
    CSV.foreach(file.path, encoding: "SJIS:UTF-8", headers: true) do |row|
      model = find_by_id(row["id"]) || new
      model.attributes = row.to_hash.slice(*column_names)
      model.save!
    end
  end

  def service_employee?
    company.try(:type) == 'Service'
  end
end
