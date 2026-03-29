class User < ApplicationRecord
  has_secure_password

  has_many :team_members, dependent: :destroy
  has_many :teams, through: :team_members
  has_many :owned_teams, class_name: "Team", foreign_key: "owner_id"
  has_many :comments, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  before_save :downcase_email

  private

  def downcase_email
    self.email = email.downcase
  end
end