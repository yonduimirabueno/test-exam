class CreateParkingLots < ActiveRecord::Migration[7.0]
  def change
    create_table :parking_lots do |t|
      t.string  :name,    null: false
      t.decimal   :flat_rate, null: false, default: 40.00
      t.decimal   :whole_day_flat_rate, null: false, default: 5000.00
      t.timestamps
    end
  end
end
