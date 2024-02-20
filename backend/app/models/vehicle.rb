# == Schema Information
#
# Table name: vehicles
#
#  id         :bigint           not null, primary key
#  plate_no   :string           not null
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Vehicle < ApplicationRecord
  TYPE = {
    'small' => Vehicles::SmallVehicle,
    'medium' => Vehicles::MediumVehicle,
    'large' => Vehicles::LargeVehicle,
    }
  
  validates :plate_no, presence: true

  def self.allowed_parking_slots
    raise "Not Implemented"
  end
end
