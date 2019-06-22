# # typed: strong

class MarkdownRender < Redcarpet::Render::HTML
  extend T::Sig
  extend T::Generic

  sig { params(value: Hash).returns(String) }
  def initialize(value); end
end
