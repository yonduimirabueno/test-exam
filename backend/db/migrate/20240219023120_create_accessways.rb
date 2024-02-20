class CreateAccessways < ActiveRecord::Migration[7.0]
  def change
    create_table :accessways do |t|
      t.references :parking_lot
      t.timestamps
    end
  end
end
