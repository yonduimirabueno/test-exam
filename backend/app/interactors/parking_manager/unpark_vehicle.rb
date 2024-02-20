module ParkingManager
  class UnparkVehicle
    include Interactor::Organizer
    organize GenerateInvoice, MakeParkingSlotAvailable
    
  end
end