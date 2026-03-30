class Api::V1::IssuesController < ApplicationController
  before_action :set_project
  before_action :set_issue, only: [:show, :update, :destroy, :move]

  def index
    issues = @project.issues
    render json: issues
  end

  def show
    render json: @issue
  end

  def create
    column = @project.columns.find(params[:column_id])
    issue = column.issues.create!(issue_params)
    broadcast_board(@project)
    render json: issue, status: :created
  end

  def update
    @issue.update!(issue_params)
    broadcast_board(@project)
    render json: @issue
  end

  def move
    new_column = @project.columns.find(params[:column_id])
    @issue.update!(column: new_column)
    broadcast_board(@project)
    render json: @issue
  end

  def destroy
    @issue.destroy
    broadcast_board(@project)
    render json: { message: "Issue deleted" }
  end

  private

  def set_project
    team = current_user.teams.find(params[:team_id])
    @project = team.projects.find(params[:project_id])
  end

  def set_issue
    @issue = @project.issues.find(params[:id])
  end

  def issue_params
    params.permit(:title, :description, :priority, :due_date, :assignee_id, :column_id)
  end

  def broadcast_board(project)
    columns = project.columns.includes(:issues)
    ActionCable.server.broadcast(
      "board_#{project.id}",
      { board: columns.as_json(include: :issues) }
    )
  end
end