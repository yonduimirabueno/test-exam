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
module Vehicles
  class MediumVehicle < Vehicle
    def self.parking_slot_types
    end
  end
end
