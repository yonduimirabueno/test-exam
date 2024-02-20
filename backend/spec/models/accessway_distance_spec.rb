# == Schema Information
#
# Table name: accessway_distances
#
#  id              :bigint           not null, primary key
#  distance        :decimal(, )      default(0.0)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  accessway_id    :bigint
#  parking_slot_id :bigint
#
# Indexes
#
#  index_accessway_distances_on_accessway_id     (accessway_id)
#  index_accessway_distances_on_parking_slot_id  (parking_slot_id)
#
require 'rails_helper'

RSpec.describe AccesswayDistance, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
