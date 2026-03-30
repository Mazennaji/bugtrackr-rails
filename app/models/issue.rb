class Issue < ApplicationRecord
  belongs_to :column
  belongs_to :assignee, class_name: "User", foreign_key: "assignee_id", optional: true
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  PRIORITIES = %w[low medium high critical].freeze

  validates :title, presence: true
  validates :priority, inclusion: { in: PRIORITIES }, allow_nil: true

  default_scope { order(:created_at) }

  def self.ransackable_attributes(auth_object = nil)
    %w[title description priority assignee_id column_id due_date created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[column assignee comments]
  end
end