Zoomus.configure do |c|
  c.api_key = ENV['ZOOM_KEY']
  c.api_secret = ENV['ZOOM_SECRET']
end

class Meeting
  attr_accessor :user

  def initialize
    @zoom = Zoomus.new
    user_list = @zoom.user_list
    @host = user_list['users'].first
  end

  def report(user_id, target_day=nil, page_number=1)
    target_day ||= Date.today.prev_month
    @zoom.report_getuserreport(
      user_id: user_id,
      from: target_day.beginning_of_month,
      to: target_day.end_of_month,
      page_size: 300,
      page_number: page_number # TODO: need to count up
    )
  end


  def data
    zoom_data['meetings']
  end

  private

  def zoom_data
    user_id = @host['id']
    zoomus_client.meeting_list(:host_id => user_id)
  end
end
