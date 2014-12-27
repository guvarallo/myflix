require 'spec_helper'

describe QueueItem do

  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer }

  describe '#rating' do
    let!(:user) { Fabricate(:user) }
    let!(:video) { Fabricate(:video) }
    let!(:queue_item) { Fabricate(:queue_item, user_id: user.id, video_id: video.id) }
    it "returns the user's video rating when the review is present" do
      review = Fabricate(:review, user_id: user.id, video_id: video.id, rating: 4)
      expect(queue_item.rating).to eq(4)
    end

    it "returns nil when the review is not present" do
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe '#rating=' do
    let!(:user) { Fabricate(:user) }
    let!(:video) { Fabricate(:video) }
    let!(:queue_item) { Fabricate(:queue_item, user_id: user.id, video_id: video.id) }
    it "updates the queue_item rating if review is present" do
      review = Fabricate(:review, user_id: user.id, video_id: video.id, rating: 4)
      queue_item.rating = 1
      expect(Review.first.rating).to eq(1)
    end

    it "clears the rating of the review if present" do
      review = Fabricate(:review, user_id: user.id, video_id: video.id, rating: 4)
      queue_item.rating = nil
      expect(Review.first.rating).to be_nil
    end

    it "creates a new rating if review is not present" do
      queue_item.rating = 1
      expect(Review.first.rating).to eq(1)
    end

  end

  describe 'default scope' do
    let!(:user) { Fabricate(:user) }
    let!(:queue_item1) { Fabricate(:queue_item, user_id: user.id, position: 1) }
    let!(:queue_item2) { Fabricate(:queue_item, user_id: user.id, position: 2) }

    it 'orders by ascending order' do
      expect(user.queue_items).to eq([queue_item1, queue_item2])
    end

  end
end
