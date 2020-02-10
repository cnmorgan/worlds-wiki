module Features
  def have_error_explanation(text)
    have_css '#error_explanation ul li', text: text
  end

  def have_title(text)
    have_css '#page-title', text: text
  end

  def have_alert(text)
    have_css '.alert', text: text
  end

  def have_nav_link(text)
    have_css '.side-nav ul li a', text: text
  end
end