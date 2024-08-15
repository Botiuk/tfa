require 'rails_helper'

RSpec.describe Fan, type: :model do
  it "is valid with valid attributes" do
    fan = build(:fan)
    expect(fan).to be_valid
  end

  it "is not valid without a nickname" do
    fan = build(:fan, nickname: nil)
    expect(fan).to_not be_valid
  end

  it "is not valid with not uniq nickname" do
    fan_one = create(:fan)
    fan_two = build(:fan, nickname: fan_one.nickname)
    expect(fan_two).to_not be_valid
  end

  it "is not valid with not uniq nickname, case sensetive false" do
    fan_one = create(:fan, nickname: "UltraS")
    fan_two = build(:fan, nickname: "uLtRaS")
    expect(fan_two).to_not be_valid
  end

  it "is not valid without a ontour_start" do
    fan = build(:fan, ontour_start: nil)
    expect(fan).to_not be_valid
  end

  it "is not valid when a ontour_start is less than 0" do
    fan = build(:fan, ontour_start: -1)
    expect(fan).to_not be_valid
  end

  it "is not valid when a ontour_start is not number" do
    fan = build(:fan, ontour_start: "Ten")
    expect(fan).to_not be_valid
  end

  it "is not valid when a ontour_start is not integer" do
    fan = build(:fan, ontour_start: 1.5)
    expect(fan).to_not be_valid
  end

  it "is valid without a description" do
    fan = build(:fan, description: nil)
    expect(fan).to be_valid
  end
end