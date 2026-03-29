class Api::V1::TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update, :destroy]

  def index
    teams = current_user.teams
    render json: teams
  end

  def show
    render json: @team
  end

  def create
    team = Team.new(team_params)
    team.owner = current_user
    team.save!

    TeamMember.create!(team: team, user: current_user, role: "owner")
    render json: team, status: :created
  end

  def update
    @team.update!(team_params)
    render json: @team
  end

  def destroy
    @team.destroy
    render json: { message: "Team deleted" }
  end

  private

  def set_team
    @team = current_user.teams.find(params[:id])
  end

  def team_params
    params.permit(:name)
  end
end