module SeedHelper
    def generate_markup(num_sections)
        markup = Faker::Lorem.paragraph(sentence_count: 15) + "\n\n"
        markup += "1. list\n{:toc}\n\n"
        for x in 1..num_sections do
            markup += "# #{Faker::Lorem.unique.word}\n\n"
            for i in 1..2 do 
                markup += "## #{Faker::Lorem.unique.word}\n\n"
                markup += "#{Faker::Lorem.paragraph(sentence_count: 25)}\n\n"
                markup += "#{Faker::Lorem.paragraph(sentence_count: 25)}\n\n"
            end
        end
        Faker::Lorem.unique.clear
        return markup
    end
end