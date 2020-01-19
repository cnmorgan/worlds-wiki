module PagesHelper

    def parse(text, params)
        Parser::Parser.to_HTML(text, params)
    end

    def as_text(text)
        Parser::Parser.to_text(text)
    end

end