# typed: strong

class Meetup::Relation < ActiveRecord::Relation
  extend T::Generic
  Elem = type_member(fixed: Meetup)
end

class Meetup < ApplicationRecord
  extend T::Sig
  extend T::Generic
  Elem = type_template(fixed: Meetup)

  sig { returns(Float) }
  def time(); end

end