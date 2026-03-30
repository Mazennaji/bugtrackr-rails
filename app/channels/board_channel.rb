class BoardChannel < ApplicationCable::Channel
  def subscribed
    project = Project.find(params[:project_id])
    stream_from "board_#{project.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end