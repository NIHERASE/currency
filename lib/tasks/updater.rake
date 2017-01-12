namespace :updater do
  task run: :environment do
    UpdateService.run
  end
end
