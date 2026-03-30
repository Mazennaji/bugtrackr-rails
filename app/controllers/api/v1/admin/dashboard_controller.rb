class Api::V1::Admin::DashboardController < Api::V1::Admin::BaseController
  def index
    render json: {
      stats: {
        total_users:    User.count,
        total_teams:    Team.count,
        total_projects: Project.count,
        total_issues:   Issue.count,
        total_comments: Comment.count,
        open_issues:    Issue.joins(:column).where.not(columns: { name: "Done" }).count,
        resolved_issues: Issue.joins(:column).where(columns: { name: "Done" }).count,
      },
      issues_by_priority: {
        low:      Issue.where(priority: "low").count,
        medium:   Issue.where(priority: "medium").count,
        high:     Issue.where(priority: "high").count,
        critical: Issue.where(priority: "critical").count,
      },
      recent_activity: {
        new_users_this_week:   User.where(created_at: 1.week.ago..).count,
        new_issues_this_week:  Issue.where(created_at: 1.week.ago..).count,
        new_teams_this_week:   Team.where(created_at: 1.week.ago..).count,
      },
      system: {
        rails_version:  Rails.version,
        ruby_version:   RUBY_VERSION,
        environment:    Rails.env,
        db_pool_size:   ActiveRecord::Base.connection_pool.size,
        uptime:         Time.now.to_i,
      }
    }
  end
end