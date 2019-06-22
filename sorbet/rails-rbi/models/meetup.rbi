# typed: strong

class Meetup
  extend T::Sig
  extend T::Generic
  Elem = type_template(fixed: Meetup)

  sig { params(id: String).returns(ActiveSupport::TimeWithZone) }
  def time(id); end
end