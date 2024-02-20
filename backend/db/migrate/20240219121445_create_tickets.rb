class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :parking_slot
      t.references :vehicle
      t.string     :plate_no, null: false
      t.boolean   :is_returning_vehicle, default: false
      t.decimal   :flat_rate, null: false, default: 0
      t.decimal   :exceeding_hourly_rate, null: false, default: 0
      t.decimal   :whole_day_flat_rate, null: false, default: 0
      t.datetime  :time_in
      t.datetime  :time_out
      t.timestamps
    end
  end
end
