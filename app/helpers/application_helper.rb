module ApplicationHelper
  include SessionsHelper

  def nav_link(variable, titles)
    if (titles.is_a?(String) && titles == variable) ||
       (titles.is_a?(Array) && titles.include?(variable))
      'nav-link active'
    else
      'nav-link'
    end
  end
end
