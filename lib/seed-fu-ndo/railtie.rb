module SeedFuNdo
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/seed_fu_ndo.rake"
    end
  end
end