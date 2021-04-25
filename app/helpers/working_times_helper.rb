module WorkingTimesHelper
  def print_time(time)
    time.strftime("%m/%d/%Y at %I:%M:%S %p")
  end
end
