module ApplicationHelper
  include SessionsHelper

  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class MarkdownRender < Redcarpet::Render::HTML
    def initialize(extensions = {})
      super extensions.merge(link_attributes: { target: '_blank' })
    end
    include Rouge::Plugins::Redcarpet
  end

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
