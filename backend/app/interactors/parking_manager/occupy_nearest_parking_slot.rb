module ParkingManager
  class OccupyNearestParkingSlot
    include Interactor

    def call
      is_available = true
      context.parking_slot = nearest_parking_slot
      
      if context.parking_slot
        context.parking_slot.with_lock do
          context.parking_slot.reload # To check if parking slot is already taken
          if !context.parking_slot.time_in
            context.parking_slot.time_in = DateTime.now
            context.parking_slot.save!
          else
            is_available = false
            break
          end
        end

        if !is_available
          # call self again to assign new parking_slot
          self.call 
        end

      else
        context.fail!(message: "No available parking slot")
      end
    end

    private

    def nearest_parking_slot
      parking_slots = context.parking_lot.parking_slots.available.with_accessway_distance(context.accessway.id).by_types(context.types).order('accessway_distances.distance ASC')
      parking_slots.first
    end
  end
end