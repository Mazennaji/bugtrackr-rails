class Team < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :team_members, dependent: :destroy
  has_many :members, through: :team_members, source: :user
  has_many :projects, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug, on: :create

  private

  def generate_slug
    self.slug = name.downcase.gsub(/\s+/, "-").gsub(/[^a-z0-9-]/, "") if name.present?
  end
end