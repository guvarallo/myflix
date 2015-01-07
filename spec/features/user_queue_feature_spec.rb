require 'spec_helper'

feature "user queue feature" do

  scenario "add and reorder videos in the queue" do
    cat = Category.create(name: 'cat')
    vid = Fabricate(:video, title: 'test', category: cat )
    vid2 = Fabricate(:video, title: 'second', category: cat )
    vid3 = Fabricate(:video, title: 'third', category: cat )

    sign_in

    add_video_to_queue(vid)
    page.should have_content(vid.title)

    visit video_path(vid)
    page.should have_no_content('+ My Queue')

    add_video_to_queue(vid2)
    add_video_to_queue(vid3)

    set_video_position(vid, 3)
    set_video_position(vid2, 1)
    set_video_position(vid3, 2)

    click_button 'Update Instant Queue'

    expect_video_position(vid2, 1)
    expect_video_position(vid3, 2)
    expect_video_position(vid, 3)

  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link '+ My Queue'
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,\'#{video.title}\')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(.,\'#{video.title}\')]//input[@type='text']").value).to eq(position.to_s)
  end
end
