require 'spec_helper'

describe ReviewsController do

  before { set_current_user }
  let(:vid) { Fabricate(:video) }

  describe 'POST create' do
    context 'with authenticated users' do

      context 'with valid inputs' do
        before { post :create, review: Fabricate.attributes_for(:review), 
                 video_id: vid.id }

        it "should redirect to the video show page" do
          expect(response).to redirect_to video_path(vid)
        end

        it "should create a review" do
          expect(Review.count).to eq(1)
        end

        it "should create a review associated with the video" do
          expect(Review.first.video).to eq(vid)
        end

        it "should create a review associated with the current user" do
          expect(Review.first.user).to eq(current_user)
        end
      end

      context 'with invalid inputs' do
        before { post :create, review: { body: "" }, video_id: vid.id }

        it "should not create a review without a body" do
          expect(vid.reviews.count).to eq(0)
        end

        it "should render the videos/show template" do
          expect(response).to render_template 'videos/show'
        end

        it "should set @video" do
          expect(assigns :video).to eq(vid)
        end
      end

    end

    context 'with unauthenticated users' do
      it_behaves_like "require_sign_in" do
        let(:action) { post :create, review: Fabricate.attributes_for(:review), 
                       video_id: vid.id }
      end
    end

  end

end
