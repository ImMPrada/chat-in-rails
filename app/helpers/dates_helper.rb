module DatesHelper
  def friendly_date(date)
    today = Time.zone.today
    date = date.to_date

    return "today at #{date.strftime('%l:%M %p')}" if date == today

    return "yesterday at #{date.strftime('%l:%M %p')}" if date == today - 1

    "#{date.strftime('%B %e, %Y')} at #{date.strftime('%l:%M %p')}"
  end

  def format_date(date)
    date.strftime('%B %e, %Y')
  end
end
