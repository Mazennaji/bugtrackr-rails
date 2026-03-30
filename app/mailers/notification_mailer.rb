class NotificationMailer < ApplicationMailer
  def issue_assigned(issue, user)
    @issue = issue
    @user = user
    @project = issue.column.project
    @team = @project.team

    mail(
      to: user.email,
      subject: "You have been assigned to: #{issue.title}"
    )
  end

  def comment_added(comment, user)
    @comment = comment
    @issue = comment.issue
    @user = user
    @project = @issue.column.project

    mail(
      to: user.email,
      subject: "New comment on: #{@issue.title}"
    )
  end
end