require 'spec_helper'

describe PasswordResetsController do
  describe "GET show" do
    it "renders show template if token is valid" do
      gus = Fabricate(:user)
      gus.update_column(:token, '12345')
      get :show, id: '12345'
      expect(response).to render_template :show
    end
    it "sets @token" do
      gus = Fabricate(:user)
      gus.update_column(:token, '12345')
      get :show, id: '12345'
      expect(assigns(:token)).to eq('12345')
    end
    it "redirects to expired token page if token is not valid" do
      get :show, id: '12345'
      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do
    context "with valid token" do
      it "redirects to sign in page" do
        gus = Fabricate(:user, password: 'password')
        gus.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(response).to redirect_to sign_in_path
      end
      it "updates the user password" do
        gus = Fabricate(:user, password: 'password')
        gus.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(gus.reload.authenticate('new_password')).to be_truthy
      end
      it "sets flash" do
        gus = Fabricate(:user, password: 'password')
        gus.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(flash[:success]).to be_present
      end
      it "regenerates the user token" do
        gus = Fabricate(:user, password: 'password')
        gus.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password'
        expect(gus.reload.token).not_to eq('12345')
      end
    end

    context "with invalid token" do
      it "redirects to expired token path" do
        post :create, token: '12345', password: 'some_password'
        expect(response).to redirect_to expired_token_path
      end
    end
  end
end
