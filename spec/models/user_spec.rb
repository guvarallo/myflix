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
      gus.video_in_queue?(video).should be_truthy
    end
    it "should return false if user did not queue the video" do
      Fabricate(:queue_item, user: gus)
      gus.video_in_queue?(video).should be_falsey
    end
  end

  describe "#following_user?" do
    let!(:gus) { Fabricate(:user) }
    let!(:ana) { Fabricate(:user) }
    before { Relationship.create(user_id: gus.id, relation_id: ana.id) }
    it "returns true if user already follows the other user" do
      expect(gus.following_user?(ana)).to be_truthy
    end
    it "returns false if user does not follow the other user" do
      expect(ana.following_user?(gus)).to be_falsey
    end
  end

end
