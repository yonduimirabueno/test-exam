module ParkingManager
  class AddAccesswaysWithSlotsDistance
    include Interactor

    def call
      context.parking_lot = ParkingLot.find_by(id: context.parking_lot_id)
      context.fail!(message: "Parking Lot Not found") unless context.parking_lot
      begin
        CsvImportAccesswaysWithDistancesService.new.call(context.parking_lot_id, context.accessways_and_distance_file)
      rescue => e
        context.fail!(message: "Parking slots file upload error. #{e.message}")
      end
    end
  end
end