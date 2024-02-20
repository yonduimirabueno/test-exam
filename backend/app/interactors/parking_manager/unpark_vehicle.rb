module ParkingManager
  class UnParkVehicle
    include Interactor::Organizer
    organize VehicleParkingSlotTypes,
            OccupyNearestParkingSlot,
            CheckIfReturningVehicle,
            GenerateTicket
  end
end