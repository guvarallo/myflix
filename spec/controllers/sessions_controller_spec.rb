require 'spec_helper'

describe SessionsController do

  describe 'GET new' do

    it "should render the new template if unauthenticated user" do
      get :new
      expect(response).to render_template :new
    end

    it "should redirect_to home_path if authenticated user" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe 'POST create' do

    context "valid username and password" do

      before do
        @user = Fabricate(:user)
        post :create, email: @user.email, password: @user.password
      end

      it "should create a session with the user's id" do
        expect(session[:user_id]).to eq(@user.id)
      end

      it "should set the flash" do
        should set_the_flash
      end

      it "should redirect_to home_path" do
        expect(response).to redirect_to home_path
      end
    end
    
    context "invalid username and password" do

      before do
        Fabricate(:user)
        post :create, email: "some@email.com", password: "somepass"
      end

      it "should not create a session" do
        expect(session[:user_id]).to be_nil
      end

      it "should set the flash" do
        should set_the_flash
      end

      it "should redirect_to sign_in_path" do
        expect(response).to redirect_to sign_in_path
      end
    end

  end

  describe 'GET destroy' do

    before do
      session[:user_id] = Fabricate(:user).id
      get :destroy
    end

    it "should destroy the user session" do
      expect(session[:user_id]).to be_nil
    end

    it "should set the flash" do
      should set_the_flash
    end

    it "should redirect_to root_path" do
      expect(response).to redirect_to root_path
    end

  end
  
end

