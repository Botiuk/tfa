# frozen_string_literal: true

require 'faker'

case Rails.env
when 'development'

  User.create(
    email: 'admin@gmail.com',
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil),
    role: 'admin'
  )

  User.create(
    email: 'fanat@gmail.com',
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil),
    role: 'fan'
  )

  User.create(
    email: 'user@gmail.com',
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil)
  )

  30.times do
    password = Faker::Internet.password(min_length: 6)
    User.create(
      email: Faker::Internet.unique.email(domain: 'gmail.com'),
      password: password,
      password_confirmation: password
    )
  end

  ActiveStorage::Blob.create!(
    key: 'w7zijcg8xc4kit0d0y051nxdygen',
    filename: 'fish_for_seeds.jpg',
    content_type: 'image/jpeg',
    metadata: '{"identified":true,"width":540,"height":360,"analyzed":true}',
    service_name: 'cloudinary',
    byte_size: 27_909,
    checksum: '/1UkXdyBz4cr1bGPz36aLQ=='
  )

  15.times do
    NewsStory.create(
      title: Faker::Movie.title.capitalize,
      published_at: Faker::Time.between(from: DateTime.now - 1.year, to: DateTime.now + 1.month)
    )
  end
  (1..15).each do |news_story_id|
    ActiveStorage::Attachment.create!(
      record_type: 'NewsStory',
      record_id: news_story_id,
      name: 'cover',
      blob_id: 1
    )
    ActionText::RichText.create!(
      record_type: 'NewsStory',
      record_id: news_story_id,
      name: 'content',
      body: Faker::Lorem.paragraph_by_chars
    )
  end

  20.times do
    Atribute.create(
      name: Faker::Commerce.product_name,
      price: Faker::Number.number(digits: 3),
      avaliable: Atribute.avaliables.keys.sample
    )
  end
  (1..20).each do |atribute_id|
    ActiveStorage::Attachment.create!(
      record_type: 'Atribute',
      record_id: atribute_id,
      name: 'atribute_photos',
      blob_id: 1
    )
  end

  20.times do
    Video.create(
      name: Faker::Book.title,
      youtube_id: [
        ['4xUEkxgnGqs', 'SfsY2DJlIdE', 'rCYCM8HYE1s', '0PY9176gEi8', 'cax1HcvsOOY', 'fV9pBVOXung', '-j7BcbcH78g',
         'MkYtsyL6TZM'].sample, Faker::Alphanumeric.alpha(number: 10)
      ].sample,
      video_type: Video.video_types.keys.sample
    )
  end

  40.times do
    Team.create(
      team_type: [Faker::Alphanumeric.alphanumeric(number: 2, min_alpha: 2).upcase, nil].sample,
      name: Faker::Sports::Football.team,
      location: Faker::Address.city
    )
  end

  30.times do
    Stadium.create(
      country: Faker::Address.country,
      region: Faker::Address.state,
      district: Faker::Address.country_code_long.downcase.capitalize,
      loctype: Stadium.loctypes.keys.sample,
      location_name: Faker::Address.city,
      address: Faker::Address.street_address,
      stadium_name: Faker::Restaurant.name
    )
  end

  5.times do
    random_date = Faker::Date.between(from: 20.years.ago, to: 1.year.ago)
    Season.create(
      start_date: random_date,
      end_date: (random_date + rand(2..12).month),
      name: Faker::Movie.title
    )
  end

  16.times do
    Tournament.create(
      name: Faker::Sports::Football.competition,
      subname: Faker::Esport.league,
      group: Faker::Esport.event
    )
  end

  16.times do
    Fan.create(
      nickname: Faker::Internet.unique.username,
      description: Faker::Lorem.paragraphs,
      ontour_start: Faker::Number.between(from: 0, to: 7)
    )
  end

  season_ids = Season.ids
  tournament_ids = Tournament.ids
  stadium_ids = Stadium.ids
  team_ids = Team.ids
  20.times do
    Match.create(
      season_id: season_ids.sample,
      tournament_id: tournament_ids.sample,
      stage: Faker::Alphanumeric.alpha(number: 5),
      stadium_id: stadium_ids.sample,
      start_at: Faker::Time.between(from: DateTime.now - 6.months, to: DateTime.now + 6.months),
      home_team_id: team_ids.sample,
      home_goal: [Faker::Number.number(digits: 1), nil].sample,
      visitor_team_id: team_ids.sample,
      visitor_goal: [Faker::Number.number(digits: 1), nil].sample,
      match_type: Match.match_types.keys.sample
    )
  end
  match_ids = Match.ids
  match_ids.each do |match_id|
    ActiveStorage::Attachment.create!(
      record_type: 'Match',
      record_id: match_id,
      name: 'photos',
      blob_id: 1
    )
  end

  fan_ids = Fan.ids
  match_ids = Match.where(match_type: 'ontour').ids
  40.times do
    FanMatch.create(
      fan_id: fan_ids.sample,
      match_id: match_ids.sample
    )
  end

  match_ids = Match.ids
  video_ids = Video.where(video_type: 'match_report').ids
  20.times do
    MatchVideo.create(
      match_id: match_ids.sample,
      video_id: video_ids.sample
    )
  end

when 'production'

  user = User.where(email: 'ternofieldarmy@gmail.com').first_or_initialize
  user.update!(
    password: ENV.fetch('SEEDS_PASS', nil),
    password_confirmation: ENV.fetch('SEEDS_PASS', nil),
    role: 'admin'
  )

end
