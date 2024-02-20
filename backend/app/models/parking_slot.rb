# == Schema Information
#
# Table name: parking_slots
#
#  id                :bigint           not null, primary key
#  is_out_of_service :boolean          default(FALSE)
#  rate              :decimal(, )      default(0.0), not null
#  time_in           :datetime
#  time_out          :datetime
#  type              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parking_lot_id    :bigint
#
# Indexes
#
#  index_parking_slots_on_parking_lot_id  (parking_lot_id)
#
class ParkingSlot < ApplicationRecord
  SLOT_TYPES = {
    'small' => ParkingSlots::SmallParkingSlot,
    'medium' => ParkingSlots::MediumParkingSlot,
    'large' => ParkingSlots::LargeParkingSlot,
    }
    
  belongs_to :parking_lot
  has_many :accessway_distances
  
  scope :available, -> { where(time_in: nil) }
  scope :by_types, ->(types) { where(type: types) }
  scope :with_accessway_distance, ->(accessway_id) { includes(:accessway_distances).where(accessway_distances: { accessway_id: accessway_id})}
end
