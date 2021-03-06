require 'seed-fu-ndo'

namespace :db do
  desc 'Unloads seed data for the current environment.'
  task unseed_fu: :environment do
    filter = /#{ENV["FILTER"].tr(',', "|")}/ if ENV['FILTER']

    if ENV['FIXTURE_PATH']
      fixture_paths = [ENV['FIXTURE_PATH'], ENV['FIXTURE_PATH'] + '/' + Rails.env]
    end

    SeedFuNdo.unseed(fixture_paths, filter)
  end

  # alias
  task unseed: 'db:unseed_fu'
end
