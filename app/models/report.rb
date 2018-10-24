class Report
  class << self
    def all(token)
      TimecrowdApi::me(token).dig('teams')
    end

    def find(token, id)
      TimecrowdApi::team_reports(team_id: id, token: token)
    end
  end
end
