# frozen_string_literal: true

FactoryBot.define do
  factory :station do
    sequence(:title) { |n| "#{Faker::Lorem.word}-#{n}" }
  end
end
