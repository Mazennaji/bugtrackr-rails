class Api::V1::ColumnsController < ApplicationController
  before_action :set_project
  before_action :set_column, only: [:update, :destroy]

  def index
    render json: @project.columns
  end

  def create
    position = @project.columns.count + 1
    column = @project.columns.create!(name: params[:name], position: position)
    render json: column, status: :created
  end

  def update
    @column.update!(column_params)
    render json: @column
  end

  def destroy
    @column.destroy
    render json: { message: "Column deleted" }
  end

  private

  def set_project
    team = current_user.teams.find(params[:team_id])
    @project = team.projects.find(params[:project_id])
  end

  def set_column
    @column = @project.columns.find(params[:id])
  end

  def column_params
    params.permit(:name, :position)
  end
end