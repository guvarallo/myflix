require 'spec_helper'

describe UsersController do

  describe 'GET new' do

    it "should set @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
    
  end

  describe 'POST create' do
    context "with valid input" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "should create the user" do
        expect(User.count).to eq(1)
      end

      it "should redirect to home_path" do
        expect(response).to redirect_to home_path
      end
    end

    context "with invalid input" do
      before { post :create, user: { email: "abc@abc.com", password: "abc" } }

      it "should not create the user" do
        expect(User.count).to eq(0)
      end
!
      it "should render the :new template" do
        should render_template(:new)
      end

      it "should set @user" do
        expect(assigns(:user)).to be_instance_of(User)        
      end

    end
  end
  
end
