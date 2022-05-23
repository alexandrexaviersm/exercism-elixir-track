defmodule LibraryFees do
  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(datetime), do: datetime.hour < 12

  def return_date(checkout_datetime) do
    return_date = if before_noon?(checkout_datetime), do: 28, else: 29

    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(return_date)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    diff = Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date)

    if diff < 0, do: 0, else: diff
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> Kernel.==(1)
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    planned_return_date = return_date(checkout_datetime)
    actual_return_datetime = datetime_from_string(return)

    days_late = days_late(planned_return_date, actual_return_datetime)
    rate = if monday?(actual_return_datetime), do: rate * 0.5, else: rate
    trunc(days_late * rate)
  end
end
