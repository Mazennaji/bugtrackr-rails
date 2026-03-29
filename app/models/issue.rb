class Issue < ApplicationRecord
  belongs_to :column
  belongs_to :assignee, class_name: "User", foreign_key: "assignee_id", optional: true

  PRIORITIES = %w[low medium high critical].freeze

  validates :title, presence: true
  validates :priority, inclusion: { in: PRIORITIES }, allow_nil: true

  default_scope { order(:created_at) }
end