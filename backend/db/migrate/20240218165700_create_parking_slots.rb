class CreateParkingSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :parking_slots do |t|
      t.references :parking_lot
      t.datetime   :time_in
      t.datetime   :time_out
      t.string     :type
      t.decimal    :rate, null: false, default: 0
      t.boolean    :is_out_of_service, default: false
      t.timestamps
    end
  end
end
