require 'rails_helper'

RSpec.describe NewsStory, type: :model do
  it "is valid with valid attributes" do
    news_story = build(:news_story)
    expect(news_story).to be_valid
  end

  it "is not valid without a title" do
    news_story = build(:news_story, title: nil)
    expect(news_story).to_not be_valid
  end

  it "is valid without a published_at" do
    news_story = build(:news_story, published_at: nil)
    expect(news_story).to be_valid
  end
end
