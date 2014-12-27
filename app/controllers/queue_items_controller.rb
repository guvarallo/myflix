class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    QueueItem.create(video: video, user: current_user, 
                     position: item_position) unless current_user.video_in_queue?(video)
    redirect_to queue_path
  end

  def update_queue
    begin
      update_queue_items
      current_user.positions_reorder
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid position number"
    end
    redirect_to queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy unless queue_item.user != current_user
    current_user.positions_reorder
    redirect_to queue_path
  end

  private

  def item_position
    current_user.queue_items.count + 1
  end

  def queue_item_params
    params.require(:queue_item).permit(:position)
  end

  def update_queue_items
    ActiveRecord::Base.transaction(requires_new: true) do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data[:id])
        queue_item.update_attributes!(position: queue_item_data[:position], 
                                      rating: queue_item_data[:rating]) if 
        queue_item.user == current_user
      end
    end
  end

end
