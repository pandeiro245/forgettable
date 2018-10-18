class MisocaApi
  class << self
    def me(token)
      url = '/v1/me'
      call_api(:get, url, token)
    end

    def contacts(token)
      url = '/v3/contacts'
      call_api(:get, url, token)
    end

    def contact(token, id)
      url = File.join('/v3/contact', id)
      call_api(:get, url, token)
    end

    private
    def base_url
      'https://app.misoca.jp/api/'
    end

    def call_api(method, path, token)
      params = {
        method: method,
        url: File.join(base_url, path),
        headers: {
          content_type: 'application/json;charset=UTF-8',
          Authorization: "Bearer #{token}"
        }
      }
      res = RestClient::Request.execute(params)
      JSON.parse(res)
    end
  end
end

