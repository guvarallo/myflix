require 'spec_helper'

describe VideosController do

  before { set_current_user }
  let(:vid) { Fabricate(:video) }

  describe 'GET show' do

    it "sets the @video variable with authenticated user" do
      get :show, id: vid.id
      expect(assigns(:video)).to eq(vid)
    end

   it_behaves_like "require_sign_in" do
      let(:action) { get :show, id: vid.id }
    end

  end

  describe 'GET search' do

    it "sets the @results variable with authenticated user" do
      get :search, search_term: vid.title[0..3]
      expect(assigns(:results)).to eq([vid])
    end

  end

end
