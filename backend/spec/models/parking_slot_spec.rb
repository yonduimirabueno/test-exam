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
require 'rails_helper'

RSpec.describe ParkingSlot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
