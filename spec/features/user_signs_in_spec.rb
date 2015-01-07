require 'spec_helper'

feature "Sign in" do

  scenario "with correct input" do
    gus = Fabricate(:user, name: 'gus')
    sign_in(gus)
    page.should have_content 'Welcome back gus!'
  end
end
