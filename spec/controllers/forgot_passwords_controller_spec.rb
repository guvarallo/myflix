require 'spec_helper'

describe ForgotPasswordsController do

  describe 'POST create' do
    context 'with blank input' do
      it 'redirects to the forgot password page' do
        post :create, email: ''
        expect(response).to redirect_to forgot_password_path
      end
      it 'shows the error message' do
        post :create, email: ''
        expect(flash[:warning]).to eq("Email cannot be blank")
      end
    end

    context 'with existing email' do
      it 'redirect to the forgot password confirmation page' do
        Fabricate(:user, email: "gus@example.com")
        post :create, email: "gus@example.com"
        expect(response).to redirect_to forgot_password_confirmation_path
      end
      it 'sends out the email to the email address' do
        Fabricate(:user, email: "gus@example.com")
        post :create, email: "gus@example.com"
        expect(ActionMailer::Base.deliveries.last.to).to eq(["gus@example.com"])
      end
    end

    context 'with non-existing email'
      it 'redirects to forgot_password page' do
        post :create, email: "gus@example.com"
        expect(response).to redirect_to forgot_password_path
      end
      it 'shows error message' do
        post :create, email: "gus@example.com"
        expect(flash[:warning]).to eq("User does not exist")
      end
  end
end
