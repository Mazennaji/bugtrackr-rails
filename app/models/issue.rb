class Issue < ApplicationRecord
  belongs_to :column
  belongs_to :assignee, class_name: "User", foreign_key: "assignee_id", optional: true
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  PRIORITIES = %w[low medium high critical].freeze

  validates :title, presence: true
  validates :priority, inclusion: { in: PRIORITIES }, allow_nil: true

  default_scope { order(:created_at) }

  after_update :notify_assignee, if: :saved_change_to_assignee_id?

  private

  def notify_assignee
    return unless assignee.present?
    NotifyAssigneeJob.perform_later(self.id)
  end
end