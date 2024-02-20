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
require 'rails_helper'

RSpec.describe ParkingLot, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
