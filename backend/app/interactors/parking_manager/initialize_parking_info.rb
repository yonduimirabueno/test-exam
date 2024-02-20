
module ParkingManager
  class InitializeParkingInfo
    include Interactor

    def call
      ActiveRecord::Base.transaction do
        context.prepared_params = prepared_params
      end
    end

    private
    def prepared_params
      {
        vehicle: vehicle,
        parking_lot: parking_lot,
        accessway: accessway
      }
    end

    def vehicle
      vehicle = Vehicle::TYPE[context.parking_info["type"]].new(plate_no: context.parking_info["plate_no"])
      context.fail!(message: vehicle.errors.full_messages.to_sentence ) unless vehicle.save
      vehicle
    end

    def parking_lot
      p_lot = ParkingLot.find_by(id: context.parking_info["parking_lot_id"])
      context.fail!(message: "Parking Lot Not found") unless p_lot
      p_lot
    end

    def accessway
      a_way = Accessway.find_by(id: context.parking_info["accessway_id"])
      context.fail!(message: "Accessway Not found") unless a_way
      a_way
    end
   
  end
end