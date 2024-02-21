# frozen_string_literal: true

FactoryBot.define do
  factory :parking_lot, class: ParkingLot do
    name { Faker::Company.name }
    after(:create) do |parking_lot|
      create_list :accessway, 3, parking_lot: parking_lot do |accessway, awi|

        create_list :small_parking_slot, 5, parking_lot: parking_lot do |sps, spsi|
          create :accessway_distance, accessway: accessway, parking_slot: sps, distance: Faker::Number.between(from: 0.0, to: 45.0).round(2)
        end
        
        create_list :medium_parking_slot, 5, parking_lot: parking_lot do |mps, mpsi|
          create :accessway_distance, accessway: accessway, parking_slot: mps, distance: Faker::Number.between(from: 0.0, to: 45.0).round(2)
        end

        create_list :large_parking_slot, 5, parking_lot: parking_lot do |lps, lpsi|
          create :accessway_distance, accessway: accessway, parking_slot: lps, distance: Faker::Number.between(from: 0.0, to: 45.0).round(2)
        end
      end

    end
  end

  factory :full_slot_parking_lot, class: ParkingLot do
    name { Faker::Company.name }
    after(:create) do |full_slot_parking_lot|
      create_list :accessway, 3, parking_lot: full_slot_parking_lot do |accessway, awi|

        create_list :small_parking_slot, 5, parking_lot: full_slot_parking_lot, time_in: DateTime.now do |sps, spsi|
          create :accessway_distance, accessway: accessway, parking_slot: sps, distance: Faker::Number.between(from: 0.0, to: 45.0).round(2)
        end
        
        create_list :medium_parking_slot, 5, parking_lot: full_slot_parking_lot, time_in: DateTime.now do |mps, mpsi|
          create :accessway_distance, accessway: accessway, parking_slot: mps, distance: Faker::Number.between(from: 0.0, to: 45.0).round(2)
        end

        create_list :large_parking_slot, 5, parking_lot: full_slot_parking_lot, time_in: DateTime.now do |lps, lpsi|
          create :accessway_distance, accessway: accessway, parking_slot: lps, distance: Faker::Number.between(from: 0.0, to: 45.0).round(2)
        end
      end

    end
  end
end
