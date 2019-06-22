# typed: strong

class Meetup < ApplicationRecord
  extend T::Sig
  extend T::Generic
  Elem = type_template(fixed: Meetup)

  sig { returns(TimeWithZone) }
  def time(); end
end