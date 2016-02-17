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

  def head_employee?
    company.try(:type) == 'Head'
  end

  def branch_employee?
    company.try(:type) == 'Branch'
  end

  def service_employee?
    company.try(:type) == 'Service'
  end

  def jurisdiction_services
    branch_employee? ? company.services : []
  end

  def places
    return Place.where(branch: company) if branch_employee?
    return Place.where(branch: company.branch) if service_employee?
    Place.all
  end

  def branch
    service_employee? ? company.branch : company
  end

  def services
    return Service.where(branch: company) if branch_employee?
    return company if service_employee?
    Service.all
  end
end
