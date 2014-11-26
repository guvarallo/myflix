class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find_by(params[:video_id])
    @review = @video.reviews.create(params.require(:review).permit(:body, :rating))
    @review.user = current_user

    if @review.save
      flash[:notice] = "Review successfully created!"
      redirect_to video_path(@video)
    else
      @video.reload
      render 'videos/show'
    end
  end
  
end