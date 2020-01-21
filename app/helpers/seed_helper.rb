module SeedHelper
    def generate_markup(num_sections)
        markup = "1. list\n{:toc}\n\n"
        for x in 1..num_sections do
            markup += "# #{Faker::Lorem.unique.word}\n\n"
            for i in 1..2 do 
                markup += "## #{Faker::Lorem.unique.word}\n\n"
                markup += "#{Faker::Lorem.paragraph}\n\n"
            end
        end
        Faker::Lorem.unique.clear
        return markup
    end
end