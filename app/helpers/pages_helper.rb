module PagesHelper

    def parse(text, params)
        Parser::Parser.toHTML(text, params)
    end

end