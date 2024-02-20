class CreateAccesswayDistances < ActiveRecord::Migration[7.0]
  def change
    create_table :accessway_distances do |t|
      t.references :accessway
      t.references :parking_slot
      t.decimal :distance, default: 0
      t.timestamps
    end
  end
end
