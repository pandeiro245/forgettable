Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  # provider :timecrowd, ENV['TIMECROWD_KEY'], ENV['TIMECROWD_SECRET']
  # provider :slack, ENV['SLACK_KEY'], ENV['SLACK_SECRET']
  # provider :google, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET']
end
OmniAuth.config.logger = Rails.logger