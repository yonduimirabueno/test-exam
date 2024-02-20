module ParkingManager
  class MakeParkingSlotAvailable
    include Interactor

    def call
      context.parking_slot.update(time_in: nil)
    end
  end
end