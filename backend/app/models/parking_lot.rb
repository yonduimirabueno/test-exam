# == Schema Information
#
# Table name: parking_lots
#
#  id                  :bigint           not null, primary key
#  flat_rate           :decimal(, )      default(40.0), not null
#  name                :string           not null
#  whole_day_flat_rate :decimal(, )      default(5000.0), not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class ParkingLot < ApplicationRecord
    has_many :parking_slots, dependent: :delete_all
    has_many :accessways, dependent: :delete_all
end
