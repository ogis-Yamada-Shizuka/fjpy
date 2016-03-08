class InspectionResult < ActiveRecord::Base
  belongs_to :user
  belongs_to :inspection_schedule
  has_one :check
  has_one :measurement
  has_one :note
  has_one :approval

  accepts_nested_attributes_for :measurement, :check, :note

  include Common
  after_commit :dump

  def setup_marker
    Gmaps4rails.build_markers(self) do |inspection_result, marker|
      marker.lat inspection_result.latitude
      marker.lng inspection_result.longitude
      marker.infowindow inspection_result.updated_at.to_s
      marker.json(title: inspection_result.user_id.to_s)
    end
  end

end
