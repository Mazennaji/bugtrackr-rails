class Api::V1::TeamMembersController < ApplicationController
  before_action :set_team

  def index
    render json: @team.team_members.includes(:user)
  end

  def create
    user = User.find_by!(email: params[:email])
    member = TeamMember.create!(team: @team, user: user, role: params[:role] || "developer")
    render json: member, status: :created
  end

  def update
    member = @team.team_members.find(params[:id])
    member.update!(role: params[:role])
    render json: member
  end

  def destroy
    member = @team.team_members.find(params[:id])
    member.destroy
    render json: { message: "Member removed" }
  end

  private

  def set_team
    @team = current_user.teams.find(params[:team_id])
  end
end