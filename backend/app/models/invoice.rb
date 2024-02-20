# == Schema Information
#
# Table name: invoices
#
#  id                    :bigint           not null, primary key
#  amount                :decimal(, )      default(0.0), not null
#  exceeding_hourly_rate :decimal(, )      default(0.0), not null
#  flat_rate             :decimal(, )      default(0.0), not null
#  plate_no              :string           not null
#  time_in               :datetime
#  time_out              :datetime
#  whole_day_flat_rate   :decimal(, )      default(0.0), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  parking_slot_id       :bigint
#  ticket_id             :bigint
#  vehicle_id            :bigint
#
# Indexes
#
#  index_invoices_on_parking_slot_id  (parking_slot_id)
#  index_invoices_on_ticket_id        (ticket_id)
#  index_invoices_on_vehicle_id       (vehicle_id)
#
class Invoice < ApplicationRecord
  TIME_GAP = 1
  belongs_to :ticket
end
