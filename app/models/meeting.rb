Zoomus.configure do |c|
  c.api_key = ENV['ZOOM_KEY']
  c.api_secret = ENV['ZOOM_SECRET']
end

class Meeting
  attr_accessor :user
  
  def initialize
    @client = Zoomus.new
    user_list = @client.user_list
    @host = user_list['users'].first
  end
  
  def report(user_id=nil, target_month=nil, meeting_id=nil)
    user_id ||= '9VovkXLUSWir1wLTz4FhnQ'
    meeting_id ||= '330-764-596'
    meeting_id = meeting_id.gsub(/-/, '')
    get(user_id, meeting_id)
  end
  
  def get(user_id, meeting_id)
    puts @host['id']
    @client.meeting_get(id: meeting_id, host_id: @host['id'])
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
