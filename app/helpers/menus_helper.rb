module MenusHelper
  def today? day
    return true if day.include?(DateTime.now.strftime('%a'))
    false
  end
end
