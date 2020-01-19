module Parser

    class Parser
        @@boldRegex = /\*([^*]+)\*/              
        @@italicRegex = /\/\/([^\/\/]+)\/\//        
        @@strikethroughRegex = /\-\-([^\-\-]+)\-\-/     
        @@underlineRegex = /__([^__]+)__/         
        @@superscriptRegex = /\^\$([^$]+)\$/      
        @@subscriptRegex = /v\$([^$)]+)\$/         
        @@headingRegex = /(#+) (.+)\n/            
        @@paragraphRegex = /{\n*([^{}]+)\n*}/
        @@sectionRegex = /\=\=([^\=]+)\=\=(?:\s*\n)([^====]*)\=\=\=\=/
        @@directlinkRegex = /\[\s*([^\[\]]+)\s*\|\s*([^\[\]]+)\]/
        @@inferredlinkRegex = /\[\s*([^\[\]\|]+)\s*\]/
        
        def self.toHTML(text, params)
            sections = []

            html = text    
            .gsub(@@paragraphRegex) { 
                puts $1
                self.formatParagraph($1)
             }
            .gsub(/\\</, '&lt;')
            .gsub(/\\>/, '&gt;')
            .gsub(@@sectionRegex      ) {
                sections << $1
                "<div id=\"#{$1}\">\n<h2>#{$1}</h2>\n#{$2}</div>"
            }
            .gsub(@@directlinkRegex) {"<a href=\"#{$1}\">#{$2}</a>"}
            .gsub(@@inferredlinkRegex) {ActionController::Base.helpers.link_to $1, Rails.application.routes.url_helpers.world_page_path(params[:world_name], $1)}
            .gsub(@@italicRegex       ) { "<i>#{$1}</i>"                           }
            .gsub(@@boldRegex         ) { "<b>#{$1}</b>"                           }   
            .gsub(@@strikethroughRegex) { "<del>#{$1}</del>"                       }           
            .gsub(@@underlineRegex    ) { "<ins>#{$1}</ins>"                       }           
            .gsub(@@superscriptRegex  ) { "<sup>#{$1}</sup>"                       }           
            .gsub(@@subscriptRegex    ) { "<sub>#{$1}</sub>"                       }     
            .gsub(@@headingRegex      ) { "<h#{$1.length}>#{$2}</h#{$1.length}>"   }

            return {html: html, sections: sections}
        end

        def self.generate_markup(num_sections)

            markup = ""

            for i in 1..num_sections do
                markup += "==#{Faker::Lorem.unique.word}==\n"

                for j in 1..3 do
                    markup += "{"
                    for k in 1..5 do
                        for x in 1..10 do
                            markup += " " + Faker::Lorem.word
                        end
                        markup += "."
                    end
                    markup += "}\n"
                end

                markup += "====\n"
            end

            return markup
        end
        

        private
            def self.formatParagraph(text)
                return text if text.include?('<h');

                return "<p>#{text}</p>\n";
            end
    end
end