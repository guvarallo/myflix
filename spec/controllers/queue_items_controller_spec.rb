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
      let(:gus) { Fabricate(:user) }
      let(:vid) { Fabricate(:video) }
      before do
        session[:user_id] = gus.id
        post :create, video_id: vid.id
      end

      it "creates the queue_item" do
        expect(QueueItem.count).to eq(1)
      end

      it "creates the queue_item associated with the video" do
        expect(QueueItem.first.video).to eq(vid)
      end

      it "creates the queue_item associated with the current_user" do
        expect(QueueItem.first.user).to eq(gus)
      end

      it "creates queue_item with the last position" do
        video = Fabricate(:video)
        post :create, video_id: video.id
        expect(QueueItem.last.position).to eq(2)
      end

      it "does not add the same video twice" do
        post :create, video_id: vid.id
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

  describe 'POST update_queue' do
    context "with valid inputs" do 
      let!(:user) { Fabricate(:user) }
      let!(:queue_item1) { Fabricate(:queue_item, user: user, position: 1) }
      let!(:queue_item2) { Fabricate(:queue_item, user: user, position: 2) }

      it "redirects to queue_path" do
        session[:user_id] = user.id
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, 
                                          {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to queue_path
      end

      it "reorders the queue_item according to the number given" do
        session[:user_id] = user.id
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, 
                                         {id: queue_item2.id, position: 1}]
        expect(user.queue_items).to eq([queue_item2, queue_item1])
      end

      it "reorders other queue_items when one item is changed" do
        session[:user_id] = user.id
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, 
                                         {id: queue_item2.id, position: 2}]
        expect(user.queue_items.map(&:position)).to eq([1, 2])
      end
    end

    context "with invalid inputs"
    context "with unauthenticated users"
    context "with queue items that do not belong to current user"
  end

  describe 'DELETE destroy' do
    let(:gus) { Fabricate(:user) }

    it "deletes the queue_item" do
      session[:user_id] = gus.id
      queue_item = Fabricate(:queue_item, user: gus)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(0)
    end

    it "redirects to queue_path" do
      session[:user_id] = gus.id
      queue_item = Fabricate(:queue_item, user: gus)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to queue_path
    end

    it "does not delete queue_item if current_user not the owner" do
      session[:user_id] = Fabricate(:user).id
      queue_item = Fabricate(:queue_item, user: gus)
      delete :destroy, id: queue_item.id
      expect(QueueItem.count).to eq(1)
    end

    it "redirects to root_path if unauthenticated user" do
      queue_item = Fabricate(:queue_item, user: gus)
      delete :destroy, id: queue_item.id
      expect(response).to redirect_to root_path
    end
  end

end
