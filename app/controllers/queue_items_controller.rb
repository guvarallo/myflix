class QueueItemsController < ApplicationController
  before_action :require_user

  def index
    @queue_items = current_user.queue_items
  end

  def create
    video = Video.find(params[:video_id])
    QueueItem.create(video: video, user: current_user, 
                     position: item_position) unless video_in_queue?(video)
    redirect_to queue_path
  end

  def update_queue
    params[:queue_items].each do |queue_item_data|
      queue_item = QueueItem.find(queue_item_data[:id])
      queue_item.update_attributes(position: queue_item_data[:position])
    end
    current_user.queue_items.each_with_index do |item, index|
      item.update_attributes(position: index + 1)
    end
    redirect_to queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    queue_item.destroy unless queue_item.user != current_user
    redirect_to queue_path
  end

  private

  def item_position
    current_user.queue_items.count + 1
  end

  def video_in_queue?(video)
    current_user.reload.queue_items.map(&:video).include?(video)
  end

  def queue_item_params
    params.require(:queue_item).permit(:position)
  end

end
