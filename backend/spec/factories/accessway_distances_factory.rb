# frozen_string_literal: true

FactoryBot.define do
  factory :accessway_distance, class: AccesswayDistance do
    association :parking_slot, factory: :parking_slot
    association :accessway, factory: :accessway
  end
end
