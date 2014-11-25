require 'spec_helper'

describe VideosController do

  describe 'GET show' do

    it "sets the @video variable with authenticated user" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "redirects user to root with unauthenticated user" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to root_path
    end

  end

  describe 'GET search' do

    it "sets the @results variable with authenticated user" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :search, search_term: video.title[0..3]
      expect(assigns(:results)).to eq([video])
    end
    
  end
  
end