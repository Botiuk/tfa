class Fan < ApplicationRecord
    has_many :fan_matches

    validates :nickname, presence: true, uniqueness: { case_sensitive: false }
    validates :ontour_start, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    private

    def self.formhelper
        Fan.order(:nickname).pluck(:nickname, :id)
    end
end
