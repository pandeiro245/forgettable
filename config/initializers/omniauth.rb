Rails.application.config.middleware.use OmniAuth::Builder do
  provider :timecrowd,
           ENV['TIMECROWD_CLIENT_ID'],
           ENV['TIMECROWD_CLIENT_SECRET'],
           client_options: { site: ENV['TIMECROWD_SITE'] }
  provider :misoca,
           ENV['MISOCA_CLIENT_ID'],
           ENV['MISOCA_CLIENT_SECRET'],
           scope: 'write'
end

OmniAuth.config.failure_raise_out_environments = []
OmniAuth.config.logger = Rails.logger
