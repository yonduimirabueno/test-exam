module ParkingManager
  class GenerateTicket
    include Interactor

    def call
      params = if context.returning_vehicle && context.previous_invoice
        returning_vehicle_ticket_params
      else
        ticket_params
      end
      
      context.ticket = Ticket.new(params)
      if !context.ticket.save
        context.fail!(message: context.ticket.errors.full_messages.to_sentence)
      end
    end

    private

    def ticket_params
      {
        exceeding_hourly_rate: context.parking_slot.rate, 
        whole_day_flat_rate: context.parking_lot.whole_day_flat_rate,
        flat_rate: context.parking_lot.flat_rate,
        vehicle_id: context.vehicle.id,
        plate_no: context.vehicle.plate_no,
        parking_slot_id:  context.parking_slot.id,
        time_in: context.parking_slot.time_in
      }
    end

    def returning_vehicle_ticket_params
      {
        is_returning_vehicle: true,
        exceeding_hourly_rate: context.previous_invoice.exceeding_hourly_rate, 
        whole_day_flat_rate: context.previous_invoice.whole_day_flat_rate,
        flat_rate: context.previous_invoice.flat_rate,
        vehicle_id: context.vehicle.id,
        plate_no: context.vehicle.plate_no,
        parking_slot_id:  context.parking_slot.id,
        time_in: context.parking_slot.time_in
      }
    end
  end
end