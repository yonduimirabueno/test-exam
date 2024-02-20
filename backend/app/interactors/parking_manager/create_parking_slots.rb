module ParkingManager
  class CreateParkingSlots
    include Interactor

    def call
      context.parking_lot = ParkingLot.find_by(id: context.parking_lot_id)
      context.fail!(message: "Parking Lot Not found") unless context.parking_lot
      context.fail!(message: "Parking Lot slots already exists.") if context.parking_lot.parking_slots.present?
      begin
        CsvImportParkingSlotsService.new.call(context.parking_lot_id, context.parking_slots_file)
      rescue => e
        context.fail!(message: "Parking slots file upload error. #{e.message}")
      end
    end
  end
end