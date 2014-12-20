require 'spec_helper'

describe ReviewsController do

  describe 'POST create' do

    context 'with authenticated users' do
      let(:current_user) { Fabricate(:user) }
      before do
        session[:user_id] = current_user.id
        @video = Fabricate(:video)
      end

      context 'with valid inputs' do
        before do
          post :create, review: Fabricate.attributes_for(:review), video_id: @video.id
        end

        it "should redirect to the video show page" do
          expect(response).to redirect_to video_path(@video)
        end

        it "should create a review" do
          expect(Review.count).to eq(1)
        end

        it "should create a review associated with the video" do
          expect(Review.first.video).to eq(@video)
        end

        it "should create a review associated with the current user" do
          expect(Review.first.user).to eq(current_user)
        end
      end

      context 'with invalid inputs' do
        before do
          post :create, review: { body: "" }, video_id: @video.id
        end

        it "should not create a review without a body" do
          expect(@video.reviews.count).to eq(0)
        end

        it "should render the videos/show template" do
          expect(response).to render_template 'videos/show'
        end

        it "should set @video" do
          expect(assigns :video).to eq(@video)
        end
      end 

    end

    context 'with unauthenticated users' do
      it "should redirect to the root path" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(response).to redirect_to root_path
      end
    end

  end

end
