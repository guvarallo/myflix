require 'spec_helper'

describe User do

  it { should have_many(:reviews).order("created_at DESC") }
  it { should have_many(:queue_items) }
  it { should have_many(:relations).through(:relationships) }
  it { should have_many(:followers).through(:inverse_relationships) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }

  describe "#video_in_queue?" do
    let!(:gus) { Fabricate(:user) }
    let!(:video) { Fabricate(:video) }
    it "should return true when the user queues the video" do
      Fabricate(:queue_item, user: gus, video: video)
      gus.video_in_queue?(video).should be_true
    end
    it "should return false if user did not queue the video" do
      Fabricate(:queue_item, user: gus)
      gus.video_in_queue?(video).should be_false
    end
  end

end
