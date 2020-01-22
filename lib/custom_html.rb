class CustomHtml < Kramdown::Converter::Html

    def convert_a(el, indent)
        puts ::User.first.username.red
        puts el.attr["href"].to_s.yellow
        format_as_span_html(el.type, el.attr, inner(el, indent))
    end

end