# typed: true
module ApplicationHelper
  include SessionsHelper
  extend T::Sig

  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  sig { params(text: String).returns(String) }
  def markdown_text(text)
    Redcarpet::Markdown.new(MarkdownRender, fenced_code_blocks: true).render(text).html_safe
  end

  def nav_link(variable, titles)
    if (titles.is_a?(String) && titles == variable) ||
       (titles.is_a?(Array) && titles.include?(variable))
      'nav-link active'
    else
      'nav-link'
    end
  end
end
