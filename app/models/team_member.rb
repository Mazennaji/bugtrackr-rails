class TeamMember < ApplicationRecord
  belongs_to :team
  belongs_to :user

  ROLES = %w[owner manager developer viewer].freeze

  validates :role, inclusion: { in: ROLES }
  validates :user_id, uniqueness: { scope: :team_id, message: "is already a member" }
end