class Api::V1::Admin::UsersController < Api::V1::Admin::BaseController
  before_action :set_user, only: [:show, :ban, :unban, :destroy, :make_admin]

  def index
    users = User.all.order(created_at: :desc)
    render json: users.map { |u| user_json(u) }
  end

  def show
    render json: user_json(@user).merge(
      teams:    @user.teams.count,
      issues:   Issue.where(assignee_id: @user.id).count,
      comments: @user.comments.count
    )
  end

  def ban
    @user.update!(banned: true)
    render json: { message: "User #{@user.email} has been banned" }
  end

  def unban
    @user.update!(banned: false)
    render json: { message: "User #{@user.email} has been unbanned" }
  end

  def make_admin
    @user.update!(admin: true)
    render json: { message: "User #{@user.email} is now an admin" }
  end

  def destroy
    @user.destroy
    render json: { message: "User deleted" }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_json(user)
    {
      id:         user.id,
      name:       user.name,
      email:      user.email,
      admin:      user.admin,
      created_at: user.created_at,
    }
  end
end