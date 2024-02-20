module ParkingManager
  class GenerateInvoice
    include Interactor
    include Parking::Calculator
  
    def call
      context.ticket = ticket
      context.parking_slot = context.ticket.parking_slot
      @time_out = DateTime.now
      calculate_amount
      context.invoice = Invoice.new(invoice_params)
      if !context.invoice.save
        context.fail!(message: context.invoice.errors.full_messages.to_sentence)
      end
    end
    
    private
    def invoice_params
      {
        amount: @amount,
        exceeding_hourly_rate: context.ticket.exceeding_hourly_rate,
        flat_rate: context.ticket.flat_rate,
        plate_no: context.ticket.plate_no,
        time_in: context.ticket.time_in,
        time_out: @time_out,
        whole_day_flat_rate: context.ticket.whole_day_flat_rate,
        parking_slot_id: context.ticket.parking_slot_id,
        ticket_id: context.ticket.id,
        vehicle_id: context.ticket.vehicle_id,
      }
    end

    def calculate_amount
      @amount = Parking::Calculator.calculate(calculate_params)
    end

    def calculate_params
      {
        is_returning_vehicle: context.ticket.is_returning_vehicle,
        exceeding_hourly_rate: context.ticket.exceeding_hourly_rate,
        flat_rate: context.ticket.flat_rate,
        time_in: context.ticket.time_in,
        time_out: @time_out,
        whole_day_flat_rate: context.ticket.whole_day_flat_rate
      }
    end

    def ticket
      ticket = Ticket.find_by(id: context.ticket_id)
      context.fail!(message: "Ticket Not found") unless ticket
      ticket
    end
  end
end