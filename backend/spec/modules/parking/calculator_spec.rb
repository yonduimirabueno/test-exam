require 'rails_helper'

RSpec.describe Parking::Calculator do
  describe ".calculate" do
    let!(:calculate_params) {
        {
          exceeding_hourly_rate: ParkingLot::DEFAULTS[:exceeding_hourly_rate],
          flat_rate: ParkingLot::DEFAULTS[:flat_rate],
          time_in: DateTime.now,
          time_out: DateTime.now,
          whole_day_flat_rate: ParkingLot::DEFAULTS[:whole_day_flat_rate]
        }
      }

    context "when time_spent below_flat_hours" do
      it "returns amount equal to flat_rate" do
        below_flat_hours = DateTime.now - 1.hours
        calculate_params[:time_in] = below_flat_hours
        amount = Parking::Calculator.calculate(calculate_params)

        expect(amount).to eq(calculate_params[:flat_rate])
      end
    end

    context "when time_spent above_flat_hours and below_whole_day" do
      it "returns amount equal to flat_rate + (exceeding_hourly_rate * exceeded_hours)" do
        # this means 9 hours of time_spent minus 3 hours flat which is 6
        above_flat_hours_below_whole_day = DateTime.now - 8.hours - 20.minutes
        
        calculate_params[:time_in] = above_flat_hours_below_whole_day
        amount = Parking::Calculator.calculate(calculate_params)

        expected_amount = calculate_params[:flat_rate] + (6 * calculate_params[:exceeding_hourly_rate])
        expect(amount).to eq(expected_amount)
      end
    end

    context "when time_spent has chunks of whole day/s" do
      context "and when flat_hours not consumed on the next day" do
        it "returns amount equal to (whole_day_flat_rate * whole_chunk_of_days) + flat_rate" do
          # this means 2 days and 2 hours of time_spent
          above_flat_hours_below_whole_day = DateTime.now - 2.days - 2.hours
          
          calculate_params[:time_in] = above_flat_hours_below_whole_day
          amount = Parking::Calculator.calculate(calculate_params)
  
          expected_amount = (2 * calculate_params[:whole_day_flat_rate]) + calculate_params[:flat_rate]
          expect(amount).to eq(expected_amount)
        end
      end
      
      context "and when flat_hours was consumed on the next day" do
        it "returns amount equal to (whole_day_flat_rate * whole_chunk_of_days) + flat_rate + (exceeding_hourly_rate * exceeded_hours)" do
          # this means 2 days and 7 hours of time_spent minus 3(flat_hour) which 4
          above_flat_hours_below_whole_day = DateTime.now - 2.days - 7.hours
          
          calculate_params[:time_in] = above_flat_hours_below_whole_day
          amount = Parking::Calculator.calculate(calculate_params)
  
          expected_amount = (2 * calculate_params[:whole_day_flat_rate]) + calculate_params[:flat_rate] + (4 * calculate_params[:exceeding_hourly_rate])
          expect(amount).to eq(expected_amount)
        end
      end
      
    end

  end
end
