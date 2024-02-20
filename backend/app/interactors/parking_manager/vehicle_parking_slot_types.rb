module ParkingManager
  class VehicleParkingSlotTypes
    include Interactor

    def call
      ParkingSlot.new() #To load subclasses
      context.types = case context.vehicle.class.to_s
      when Vehicles::SmallVehicle.to_s
        [
          ParkingSlots::SmallParkingSlot.to_s,
          ParkingSlots::MediumParkingSlot.to_s,
          ParkingSlots::LargeParkingSlot.to_s,
        ]
      when Vehicles::MediumVehicle.to_s
        [
          ParkingSlots::MediumParkingSlot.to_s,
          ParkingSlots::LargeParkingSlot.to_s,
        ]
      when Vehicles::LargeVehicle.to_s
        [
          ParkingSlots::LargeParkingSlot.to_s,
        ]
      else
        []
      end
    end
  end
end