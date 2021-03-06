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

    context "send email" do
      before { post :create, user: Fabricate.attributes_for(:user) }
      it "sends the email" do
        ActionMailer::Base.deliveries.should_not be_empty
      end

      it "sends to the right recepient" do
        message = ActionMailer::Base.deliveries.last
        message.to.should == [current_user.email]
      end

      it "has the right content" do
        message = ActionMailer::Base.deliveries.last
        message.encoded.should include(current_user.name)
      end
    end

    context "with invalid input" do
      before { post :create, user: { email: "abc@abc.com", password: "abc" } }
      it "should not create the user" do
        expect(User.count).to eq(0)
      end

      it "should render the :new template" do
        should render_template(:new)
      end

      it "should set @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe 'GET show' do
    it_behaves_like "require_sign_in" do
      let(:action) { post :show, id: 1 }
    end
    let(:gus) { Fabricate(:user) }
    before { set_current_user }
    before { get :show, id: gus.id }
    it { expect(assigns :user).to eq(gus) }
  end

end
