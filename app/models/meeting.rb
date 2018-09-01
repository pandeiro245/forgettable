Zoomus.configure do |c|
  c.api_key = ENV['ZOOM_KEY']
  c.api_secret = ENV['ZOOM_SECRET']
end

class Meeting
  def initialize(user_names=nil, target_day = nil)
    @zoom = Zoomus.new
    @host_id = ENV['ZOOM_HOST']
    @user_names = user_names || ENV['ZOOM_USERNAMES'].split(',')
    @target_day = target_day || Date.today.prev_month
  end

  def monthly_amount
    monthly_hour.to_i * 1000
  end

  def monthly_hour
    target_seconds.reduce(:+) / 3600
  end

  # private
  def target_seconds
    target_meetings.map do |meeting|
      user = meeting['participants'].select{|user| target_user?(user)}.first
      user['leave_time'].to_datetime.to_f - user['join_time'].to_datetime.to_f
    end
  end

  def target_meetings
    meetings.select{ |meeting| target_meeting?(meeting) }
  end

  def target_meeting?(meeting)
    meeting['participants'].select{|user| target_user?(user) }.present?
  end

  def target_user?(user)
    @user_names.each do |user_name|
      return true if user['name'].match(user_name)
    end
    false
  end

  def meetings
    data = []
    page_number = 1
    loop do
      res = user_report(page_number)
      data += res['meetings']

      if res['page_count'] <= page_number
        return data
      else
        page_number += 1
      end
    end
  end

  def user_report(page_number=1, refresh = false)
    file_path = "tmp/zoom_user_report.txt"

    return JSON.parse(File.open(file_path, 'r').read) if !refresh && ENV['OFFLINE_MODE']

    res = @zoom.report_getuserreport(
      user_id: @host_id,
      from: @target_day.beginning_of_month,
      to: @target_day.end_of_month,
      page_size: 300,
      page_number: page_number
    )
    if res['error']
      puts res['error']['message']
      sleep 10
      res = user_report(page_number, refresh)
    end
    File.open(file_path, 'w') { |file| file.write(res.to_json)} if refresh
    res
  end
end
