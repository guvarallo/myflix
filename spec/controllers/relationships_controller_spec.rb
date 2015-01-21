require 'spec_helper'

describe RelationshipsController do

  describe 'POST create' do
    let!(:gus) { Fabricate(:user) }
    let!(:bob) { Fabricate(:user) }
    before { set_current_user(gus) }
    it "creates a relation for the current user" do
      post :create, relation_id: bob.id
      expect(gus.relations.first).to eq(bob)
    end
    it "redirects to people_path" do
      post :create, relation_id: bob.id 
      expect(response).to redirect_to people_path
    end
    it "does not create a relation for another user" do
      post :create, user: bob, relation_id: gus.id
      expect(bob.relations.count).to eq(0)
    end
    it "does not follow the same person twice" do
      Relationship.create(user: gus, relation_id: bob.id)
      post :create, relation_id: bob.id
      expect(gus.relations.count).to eq(1)
    end
    it "does not follow oneself" do
      post :create, relation_id: gus.id
      expect(gus.relations.count).to eq(0)
    end
    it_behaves_like "require_sign_in" do
      let(:action) { post :create, user: gus, relation_id: bob.id }
    end
  end

  describe 'DELETE destroy' do
    let!(:gus) { Fabricate(:user) }
    let!(:bob) { Fabricate(:user) }
    let!(:relationship) { Relationship.create(user: gus, relation_id: bob.id) }
    before { set_current_user(gus) }
    it "destroys the relationship for the current user" do
      delete :destroy, id: relationship.id
      expect(gus.relations.count).to eq(0)
    end
    it "redirects to people_path" do
      delete :destroy, id: relationship.id
      expect(response).to redirect_to people_path
    end
    it_behaves_like "require_sign_in" do
      let(:action) { delete :destroy, id: 1 }
    end
  end

end
