# typed: false

class MarkdownRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
  extend T::Sig

  sig { params(extensions: Hash).void }
  def initialize(extensions = {})
    super extensions.merge(link_attributes: { target: '_blank' })
  end
end
