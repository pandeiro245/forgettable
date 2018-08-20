Zoomus.configure do |c|
  c.api_key = ENV['ZOOM_KEY']
  c.api_secret = ENV['ZOOM_SECRET']
end

class Meeting
  def initialize(user_name=nil, target_day = nil)
    @zoom = Zoomus.new
    @host_id = ENV['ZOOM_HOST']
    @user_name = user_name || ENV['ZOOM_USERNAME']
    @target_day = target_day || Date.today.prev_month
  end

  def monthly_amount
    monthly_hour.to_i * 1000
  end

  def monthly_hour
    target_minutes.reduce(:+)/3600
  end

  # private
  def target_minutes
    target_meetings.map do |meeting|
      user = meeting['participants'].select{|user| user['name'] == @user_name}.first
      user['leave_time'].to_datetime.to_f - user['join_time'].to_datetime.to_f
    end
  end

  def target_meetings
    meetings.select do |meeting|
      meeting['participants'].select do |user|
        user['name'] == @user_name
      end.present?
    end
  end

  def meetings
    user_report['meetings']
  end

  def user_report(page_number=1)
    res = @zoom.report_getuserreport(
      user_id: @host_id,
      from: @target_day.beginning_of_month,
      to: @target_day.end_of_month,
      page_size: 300,
      page_number: page_number # TODO: need to count up
    )
    if res['error']
      puts res['error']['message']
      sleep 10
      user_report(page_number)
    else
      res
    end
  end
end
