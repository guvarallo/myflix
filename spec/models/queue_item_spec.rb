require 'spec_helper'

describe QueueItem do

  it { should belong_to(:user) }
  it { should belong_to(:video) }

  describe '#rating' do

    it "returns the user's video rating when the review is present" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      review = Fabricate(:review, user_id: user.id, video_id: video.id, rating: 4)
      queue_item = Fabricate(:queue_item, user_id: user.id, video_id: video.id)
      expect(queue_item.rating).to eq(4)
    end

    it "returns nil when the review is not present" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user_id: user.id, video_id: video.id)
      expect(queue_item.rating).to eq(nil)
    end

  end

end
