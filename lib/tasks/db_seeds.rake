# lib/tasks/db_seeds.rake
namespace :db do
  namespace :seed do
    desc "Seed zones"
    task zones: :environment do
      load 'db/seeds/zones.rb'
    end
  end
end
