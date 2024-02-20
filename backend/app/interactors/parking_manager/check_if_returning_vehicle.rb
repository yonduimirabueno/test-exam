module ParkingManager
  class CheckIfReturningVehicle
    include Interactor

    def call
      context.returning_vehicle = false
      invoice = Invoice.where(plate_no: context.vehicle.plate_no).order(time_out: :desc).first
      
      if invoice && below_time_gap?(invoice)
        context.returning_vehicle = true
        # Add previous invoice to context
        context.previous_invoice = invoice
      end
    end

    private

    def below_time_gap?(invoice)
      invoice.time_out < invoice.time_out + Invoice::TIME_GAP.hours
    end
  end
end