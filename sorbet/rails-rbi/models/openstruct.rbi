# typed: strong

class OpenStruct::Relation < ActiveRecord::Relation
  extend T::Generic
  Elem = type_member(fixed: OpenStruct)
end

class OpenStruct < ApplicationRecord
  extend T::Sig
  extend T::Generic
  Elem = type_template(fixed: OpenStruct)

  sig { returns(Integer) }
  def yes_rsvp_count(); end

end