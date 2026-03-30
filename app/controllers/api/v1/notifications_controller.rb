class Api::V1::NotificationsController < ApplicationController
  def index
    notifications = current_user.notifications.recent
    render json: notifications
  end

  def unread
    notifications = current_user.notifications.unread.recent
    render json: notifications
  end

  def mark_read
    notification = current_user.notifications.find(params[:id])
    notification.mark_as_read!
    render json: { message: "Marked as read" }
  end

  def mark_all_read
    current_user.notifications.unread.update_all(read_at: Time.current)
    render json: { message: "All notifications marked as read" }
  end
end