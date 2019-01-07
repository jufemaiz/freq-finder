# frozen_string_literal: true

FactoryBot.define do
  factory :station do
    sequence(:title) { |n| "#{Faker::Lorem.word}-#{n}" }

    factory :station_with_transmitters do
      transient do
        count { 5 }
      end

      after(:create) do |station, evaluator|
        create_list(:transmitter, evaluator.count, station: station)
      end
    end
  end
end
