module PagesHelper

    def parse(text)
        Kramdown::Document.new(text, parse_block_html: true).to_custom_html
    end

end