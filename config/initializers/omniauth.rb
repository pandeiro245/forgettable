Rails.application.config.middleware.use OmniAuth::Builder do
  provider :timecrowd,
           Rails.application.credentials.timecrowd[:client_id],
           Rails.application.credentials.timecrowd[:client_secret],
           client_options: { site: Rails.application.credentials.timecrowd[:site] }
  provider :misoca,
           Rails.application.credentials.misoca[:client_id],
           Rails.application.credentials.misoca[:client_secret],
           scope: 'write'
end

OmniAuth.config.failure_raise_out_environments = []
OmniAuth.config.logger = Rails.logger
