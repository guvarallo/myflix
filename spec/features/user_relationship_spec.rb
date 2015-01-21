require 'spec_helper'

feature "user relationship" do

  scenario "user follows other user" do
    gus = Fabricate(:user)
    ana = Fabricate(:user)
    cat = Category.create(name: 'cat')
    vid = Fabricate(:video, category: cat )
    Fabricate(:review, user_id: ana.id, video_id: vid.id)

    sign_in(gus)

    click_on_video(vid)
    page.should have_content(vid.title)

    click_link ("#{ana.name}")
    page.should have_content("#{ana.name}")

    click_link 'Follow'
    page.should have_content("#{ana.name}")

    delete_relationship
    page.should have_no_content("#{ana.name}")
  end

  def click_on_video(video)
    find("a[href='/videos/#{video.id}']").click
  end

  def delete_relationship
    find("a[href='/relationships/1']").click
  end

end
