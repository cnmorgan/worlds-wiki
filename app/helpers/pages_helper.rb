module PagesHelper

    def parse(text, params)
        { html: Kramdown::Document.new(text, parse_block_html: true).to_custom_html }
    end

    def as_text(text)
        Parser::Parser.to_text(text)
    end

end