# == Schema Information
#
# Table name: tickets
#
#  id                    :bigint           not null, primary key
#  exceeding_hourly_rate :decimal(, )      default(0.0), not null
#  flat_rate             :decimal(, )      default(0.0), not null
#  is_returning_vehicle  :boolean          default(FALSE)
#  plate_no              :string           not null
#  time_in               :datetime
#  time_out              :datetime
#  whole_day_flat_rate   :decimal(, )      default(0.0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  parking_slot_id       :bigint
#  vehicle_id            :bigint
#
# Indexes
#
#  index_tickets_on_parking_slot_id  (parking_slot_id)
#  index_tickets_on_vehicle_id       (vehicle_id)
#
class Ticket < ApplicationRecord
  has_many :invoices
  belongs_to :parking_slot
end
