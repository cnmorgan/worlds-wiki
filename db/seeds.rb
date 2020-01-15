puts "Creating admin\n".blue

admin = User.new(email: "admin@test.com", 
                 username: "admin", password: "password", 
                 password_confirmation: "password", 
                 is_site_admin: true, 
                 activated: true,
                 activated_at: Time.zone.now)
admin.save

puts "Admin created\n".green

puts "=====Creating additional users=====\n".blue

for i in 1..9 do
    user = User.new(email: Faker::Internet.unique.email, 
                    username: Faker::Internet.unique.username, 
                    password: "password",
                    password_confirmation: "password",
                    activated: true,
                    activated_at: Time.zone.now)
    saved = user.save
    if saved
        puts "Successfully created user: #{user.username}"
    else
        puts "Failed to save user: #{user.username}".red
    end
end

puts "\n=====Finished creating users=====\n".green

puts "\n=====Creating Worlds=====\n".blue

User.find_each do |user|

    user.owned_worlds.create(name: Faker::Book.unique.title)
    world = user.owned_worlds.last
    puts "\nCreating world: #{world.name} for #{user.username}\n".green

    print "Adding pages".yellow

    for j in 1..36 do
        world.sub_wiki.pages.create(title: Faker::Books::Lovecraft.unique.word, summary: "{This is a summary stub}", content: Parser::Parser.generate_markup(5))
        print '.'.yellow
    end

    puts "\ndone\n".green

    print "Adding Categories".yellow

    for j in 1..15 do
        world.sub_wiki.categories.create(name: Faker::Nation.unique.nationality)
        print '.'.yellow
    end

    puts "\ndone\n".green

    print "Connecting pages to categories".yellow

    world.sub_wiki.categories.find_each do |category|
        count = world.sub_wiki.pages.count
        random_offset = rand(count)
        category.pages << world.sub_wiki.pages.offset(random_offset).first(15)
        print '.'.yellow
    end

    puts "\ndone\n".green

    print "Connecting categories to sub-categories".yellow

    world.sub_wiki.categories.find_each do |category|
        count = world.sub_wiki.categories.where.not(name: category.name).count
        random_offset = rand(count-5)
        category.sub_categories << world.sub_wiki.categories.where.not(name: category.name).offset(random_offset).first(5)
        print '.'.yellow
    end

    puts "\ndone\n".green

    print "Adding admins to worlds".yellow

    count = User.count
    random_offset = rand(count)
    world.admins << User.where.not(username: user.username).order('random()').first(4)
    print '.'.yellow
    
    puts "\ndone\n".green
    
    Faker::Books::Lovecraft.unique.clear
    Faker::Nation.unique.clear
    Faker::Lorem.unique.clear
    
    puts "\nWorld Created\n".green
    
end

puts "Creating Info world".green

world = admin.owned_worlds.create(name: "Worlds Wiki")
world.sub_wiki.pages.create(title: "Welcome", summary: "{Welcome to WorldsWiki!}", content:Parser::Parser.generate_markup(2))

puts "done".green

puts "\n=====Finished creating worlds=====\n".green