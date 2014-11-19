require 'spec_helper'

describe Video do

  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  describe 'search_by_title' do

    it "should return an empty array if there's no match" do
      Video.create(title: "Monk", description: "Monk movie")
      expect(Video.search_by_title("Pulp Fiction")).to eq([])
    end

    it "should return all videos with exact match" do
      Video.create(title: "Monk", description: "Monk movie")
      Video.create(title: "Monk", description: "Monk movie second one")
      Video.create(title: "Mo", description: "Monk movie second one")
      expect(Video.search_by_title("Monk").size).to eq(2)
    end
    
    it "should return all videos with partial match" do
      video = Video.create(title: "Monk", description: "Monk movie")
      expect(Video.search_by_title("Mo")).to eq([video])
    end

    it "should return all videos ordered by created_at ASC" do
      video1 = Video.create(title: "Monk", description: "Monk movie")
      video2 = Video.create(title: "Monk", description: "Monk movie second one")
      expect(Video.search_by_title("Monk").order(created_at: :asc)).to eq([video1, video2])
    end

    it "should return an empty array if passed an empty string" do
      video1 = Video.create(title: "Monk", description: "Monk movie")
      video2 = Video.create(title: "Monk", description: "Monk movie second one")
      expect(Video.search_by_title("")).to eq([])
    end

  end

end