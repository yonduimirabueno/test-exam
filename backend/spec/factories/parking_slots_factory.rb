# frozen_string_literal: true

FactoryBot.define do
  factory :parking_slot, class: ParkingSlot do
    association :parking_lot, factory: :parking_lot
  end

  factory :small_parking_slot, parent: :parking_slot, class: ParkingSlots::SmallParkingSlot do
    association :parking_lot, factory: :parking_lot
  end
  
  factory :medium_parking_slot, parent: :parking_slot, class: ParkingSlots::MediumParkingSlot do
    association :parking_lot, factory: :parking_lot
  end

  factory :large_parking_slot, parent: :parking_slot, class: ParkingSlots::LargeParkingSlot do
    association :parking_lot, factory: :parking_lot
  end
end
