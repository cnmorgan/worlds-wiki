namespace :dev do

    desc "Reset the development database"
    task :reset_db do
        unless Rails.env.production?
            puts "Dropping Database...".blue
            Rake::Task['db:drop'].invoke()
            puts "Creating new Database...".blue
            Rake::Task['db:create'].invoke()
            puts "Running Migrations..."
            Rake::Task['db:migrate'].invoke()
            puts "Seeding Databse...\n".blue
            Rake::Task['db:seed'].invoke()
            puts "Database reset complete\n".green
        else
            puts "This command can only be run in development".red
        end
    end

end