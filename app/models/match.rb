class Match < ApplicationRecord
    belongs_to :season
    belongs_to :tournament
    belongs_to :stadium
    belongs_to :home_team, class_name: 'Team'
    belongs_to :visitor_team, class_name: 'Team'

    has_many :fan_matches
    has_many :match_videos

    validates :home_goal, :visitor_goal, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
    validates :start_at, :match_type, presence: true

    enum :match_type, { home: 0, ontour: 1, friendly: 2 }, prefix: true

    private
    
    def self.formhelper
        matches = Match.where.not(match_type: "friendly").order(start_at: :desc).pluck(:start_at, :id)
        matches.map do |element|
            match = Match.includes(:home_team, :visitor_team).where(id: element[1]).first
            element[0] = "#{I18n.l(match.start_at, format: :only_date)}" + " | " + "#{match.home_team.name}" + " - " + "#{match.visitor_team.name}"
        end
        return matches
    end

    def self.calendar(season_id)
        Match.includes(:home_team, :visitor_team).where(season_id: season_id).order(start_at: :asc)
    end
end
