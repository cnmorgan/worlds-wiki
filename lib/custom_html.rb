class CustomHtml < Kramdown::Converter::Html

    def convert_a(el, indent)
        format_as_span_html(el.type, el.attr, inner(el, indent))
    end

end