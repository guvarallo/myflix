require 'spec_helper'

describe QueueItemsController do
  
  describe 'GET index' do
    
    it "sets @queue_items to the queue items of the logged in user" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      queue_item1 = Fabricate(:queue_item, user: user)
      queue_item2 = Fabricate(:queue_item, user: user)
      get :index
      expect(assigns :queue_items).to match_array([queue_item1, queue_item2])
    end

    it "redirects to root path if unauthenticated user" do
      get :index
      expect(response).to redirect_to root_path
    end

  end

  describe 'POST create' do

    context "authenticated users" do
      before do
        @user = Fabricate(:user)
        @video = Fabricate(:video)
        session[:user_id] = @user.id
        post :create, video_id: @video.id
      end

      it "creates the queue_item" do
        expect(QueueItem.count).to eq(1)
      end

      it "creates the queue_item associated with the video" do
        expect(QueueItem.first.video).to eq(@video)
      end

      it "creates the queue_item associated with the current_user" do
        expect(QueueItem.first.user).to eq(@user)
      end

      it "creates queue_item with the last position" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.last.position).to eq(2)
      end

      it "does not add the same video twice" do
        post :create, video_id: @video.id
        expect(QueueItem.count).to eq(1)
      end

      it "redirects to queue_path" do
        expect(response).to redirect_to queue_path
      end
    end

    context "unauthenticated users" do
      it "redirects to root path if unauthenticated user" do
        user = Fabricate(:user)
        video = Fabricate(:video)
        post :create, queue_item: Fabricate.attributes_for(:queue_item), 
                                  video_id: video.id, user_id: user.id
        expect(response).to redirect_to root_path
      end
    end
  end

end