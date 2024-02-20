module ParkingManager
  class ParkVehicle
    include Interactor::Organizer
    organize VehicleParkingSlotTypes,
            OccupyNearestParkingSlot,
            CheckIfReturningVehicle,
            GenerateTicket
  end
end