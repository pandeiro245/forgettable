OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:misoca] = OmniAuth::AuthHash.new(
  provider: 'misoca',
  uid: '123545',
  info: {
    email: 'omniauth@example.com'
  }
)
