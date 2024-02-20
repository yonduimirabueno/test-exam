class CsvImportParkingSlotsService
  require 'csv'

  def call(parking_lot_id, file)
    opened_file = File.open(file)
    options = { col_sep: ';' }
    @accessways = []
    CSV.foreach(opened_file, **options).with_index do |row, i|
      slots = row[0].split(",")
      accessway_count = slots.count - 1
      if i == 0
        (1..accessway_count).each do |aw|
          accessway = Accessway.create(parking_lot_id: parking_lot_id)
          @accessways << accessway
        end
      end

      parking_slot = ParkingSlot::SLOT_TYPES[slots[0]].create(parking_lot_id: parking_lot_id)
      @accessways.each_with_index do |accessway, i|
        parking_slot.accessway_distances.create(distance: slots[i], accessway_id: accessway.id)
      end
    
      # for performance, you could create a separate job to import each parking_slot
      # CsvImportJob.perform_later(parking_slot_hash)
    end
  end
end
