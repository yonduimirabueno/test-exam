# frozen_string_literal: true

FactoryBot.define do
  factory :accessway, class: Accessway do
    association :parking_lot, factory: :parking_lot
  end
end
