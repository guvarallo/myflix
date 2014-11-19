require 'spec_helper'

describe Category do

  it { should have_many(:videos) }

  describe "#recent_videos" do
    it "should display up to 6 videos by created_at DESC" do
      c = Category.create(name: "Comedy")
      v1 = Video.create(title: "Monk", description: "Monk movie 1", category: c)
      v2 = Video.create(title: "Monk", description: "Monk movie 2", category: c)
      v3 = Video.create(title: "Monk", description: "Monk movie 3", category: c)
      v4 = Video.create(title: "Monk", description: "Monk movie 4", category: c)
      v5 = Video.create(title: "Monk", description: "Monk movie 5", category: c)
      v6 = Video.create(title: "Monk", description: "Monk movie 6", category: c)
      v7 = Video.create(title: "Monk", description: "Monk movie 7", category: c)
      expect(c.recent_videos).to eq([v7, v6, v5, v4, v3, v2])
    end

    it "should return an empty array if category has no videos" do
      
    end

  end
  
end