require 'spec_helper'

describe RelationshipsController do

  describe 'POST create' do
    it "creates a relation for the current user"
    it "redirects to people_path" do
      gus = Fabricate(:user)
      bob = Fabricate(:user)
      session[:user_id] = gus.id
      post :create, relation_id: bob.id
      expect(response).to redirect_to people_path
    end
    it "does not create a relation for another user"
  end

  describe 'DELETE destroy' do

  end

end
