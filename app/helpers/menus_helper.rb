module MenusHelper
  def today? day
    return true if Time.now.to_s.include?(day[0, 2])
    false
  end
end
