class TimecrowdApi
  class << self
    def me(token)
      url = '/api/v1/user/info'
      call_api(:get, url, token)
    end

    def team_reports(team_id: nil, month: nil, token: nil)
      month ||= Date.today
      from = month.beginning_of_month.strftime('%Y-%m-%d')
      to   = month.end_of_month.strftime('%Y-%m-%d')

      url = "/api/v1/teams/#{team_id}/report/team?user_id=null&from=#{from}&to=#{to}"
      call_api(:get, url, token)
    end

    def report_periods(token)
      url = '/api/v1/reports/periods'
      call_api(:get, url, token)
    end

    private
    def base_url
      'https://timecrowd.net'
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
