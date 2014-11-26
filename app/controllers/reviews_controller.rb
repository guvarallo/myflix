class ReviewsController < ApplicationController
  before_action :require_user

  def create
    @video = Video.find(params[:video_id])
    @review = @video.reviews.build(review_params.merge!(user: current_user))

    if @review.save
      redirect_to video_path(@video)      
    else
      render 'videos/show'
    end
  end

  def review_params
    params.require(:review).permit(:body, :rating)
  end

end