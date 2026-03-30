class NotifyAssigneeJob < ApplicationJob
  queue_as :default

  def perform(issue_id)
    issue = Issue.find_by(id: issue_id)
    return unless issue&.assignee.present?

    Notification.create!(
      user: issue.assignee,
      notifiable: issue,
      read_at: nil
    )
  end
end