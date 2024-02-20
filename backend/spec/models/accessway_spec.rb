# == Schema Information
#
# Table name: accessways
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  parking_lot_id :bigint
#
# Indexes
#
#  index_accessways_on_parking_lot_id  (parking_lot_id)
#
require 'rails_helper'

RSpec.describe Accessway, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
