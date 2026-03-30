class Api::V1::CommentsController < ApplicationController
  before_action :set_issue
  before_action :set_comment, only: [:destroy]

  def index
    render json: @issue.comments.includes(:user)
  end

  def create
    comment = @issue.comments.create!(
      body: params[:body],
      user: current_user
    )

    notify_assignee_of_comment(comment)
    render json: comment, status: :created
  end

  def destroy
    raise ExceptionHandler::AuthenticationError, "Not authorized" unless @comment.user == current_user
    @comment.destroy
    render json: { message: "Comment deleted" }
  end

  private

  def set_issue
    team = current_user.teams.find(params[:team_id])
    project = team.projects.find(params[:project_id])
    @issue = project.issues.find(params[:issue_id])
  end

  def set_comment
    @comment = @issue.comments.find(params[:id])
  end

  def notify_assignee_of_comment(comment)
    return unless @issue.assignee.present?
    return if @issue.assignee == current_user

    NotificationMailer.comment_added(comment, @issue.assignee).deliver_later
  end
end