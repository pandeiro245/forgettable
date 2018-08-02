class Meeting
  def fetch
		Zoomus.configure do |c|
			c.api_key = ENV['ZOOM_KEY']
			c.api_secret = ENV['ZOOM_SECRET']
		end

		zoomus_client = Zoomus.new

		user_list = zoomus_client.user_list
		user = user_list['users'].first

		user_id = user['id']
		zoomus_client.meeting_list(:host_id => user_id)

  end
end
