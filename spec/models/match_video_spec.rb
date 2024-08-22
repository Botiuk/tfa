require 'rails_helper'

RSpec.describe MatchVideo, type: :model do
  it "is valid with valid attributes" do
    match_video = build(:match_video)
    expect(match_video).to be_valid
  end

  it "is not valid without a video" do
    match_video = build(:match_video, video_id: nil)
    expect(match_video).to_not be_valid
  end

  it "is not valid without a match" do
    match_video = build(:match_video, match_id: nil)
    expect(match_video).to_not be_valid
  end

  it "is not valid with same video" do
    match_video_one = create(:match_video)
    match_video_two = build(:match_video, video_id: match_video_one.video.id)
    expect(match_video_two).to_not be_valid
  end
end
