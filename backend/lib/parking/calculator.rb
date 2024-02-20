module Parking
  module Calculator
    FLAT_RATE_HOURS = 3.hours
    FLAT_RATE_DAYS = 1.days
    HOUR_IN_SECONDS = 1.hours.to_i
    DAY_IN_SECONDS = 1.days.to_i

    def self.calculate(params)
      amount = 0
      time_spent = time_diff(params[:time_in], params[:time_out])

      if below_flat_hours?(time_spent)
        amount = params[:flat_rate]
      elsif above_flat_hours?(time_spent) && below_whole_day?(time_spent)
        amount = params[:flat_rate] + amount_after_flat_rate(params[:exceeding_hourly_rate], time_spent)
      elsif above_or_equal_whole_day?(time_spent)
        amount = amount_after_whole_day(params[:flat_rate], params[:exceeding_hourly_rate], params[:whole_day_flat_rate], time_spent)
      else
        # do nothing
      end

      amount
    end

    def self.time_diff(time_in, time_out)
      (time_out.to_i - time_in.to_i)
    end

    def self.below_flat_hours?(time_spent)
      time_spent < FLAT_RATE_HOURS.to_i
    end

    def self.above_flat_hours?(time_spent)
      time_spent > FLAT_RATE_HOURS.to_i
    end

    def self.below_whole_day?(time_spent)
      time_spent < FLAT_RATE_DAYS.to_i
    end

    def self.above_or_equal_whole_day?(time_spent)
      time_spent >= FLAT_RATE_DAYS.to_i
    end

    def self.amount_after_flat_rate(exceeding_hourly_rate, time_spent)
      exceeded_seconds = time_spent - FLAT_RATE_HOURS.to_i
      hours, remainder = exceeded_seconds.divmod(HOUR_IN_SECONDS)
      hours += 1 if remainder > 0
      hours * exceeding_hourly_rate
    end

    def self.amount_after_whole_day(flat_rate, exceeding_hourly_rate, whole_day_flat_rate, time_spent)
      amount = 0
      days, remainder = time_spent.divmod(DAY_IN_SECONDS)
      amount = (days * whole_day_flat_rate)
      
      if below_flat_hours?(remainder)
        amount += flat_rate
      elsif above_flat_hours?(remainder) && below_whole_day?(remainder)
        amount += flat_rate + amount_after_flat_rate(exceeding_hourly_rate, remainder)
      else
        # do nothing
      end
      amount
    end
  end
end