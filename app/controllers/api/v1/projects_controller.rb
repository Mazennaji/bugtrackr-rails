class Api::V1::ProjectsController < ApplicationController
  before_action :set_team
  before_action :set_project, only: [:show, :update, :destroy]

  def index
    render json: @team.projects
  end

  def show
    render json: @project
  end

  def create
    project = @team.projects.create!(project_params)
    render json: project, status: :created
  end

  def update
    @project.update!(project_params)
    render json: @project
  end

  def destroy
    @project.destroy
    render json: { message: "Project deleted" }
  end

  private

  def set_team
    @team = current_user.teams.find(params[:team_id])
  end

  def set_project
    @project = @team.projects.find(params[:id])
  end

  def project_params
    params.permit(:name, :description)
  end
end