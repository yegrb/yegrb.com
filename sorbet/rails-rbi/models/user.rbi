# This is an autogenerated file for dynamic methods in User
# Please rerun rake rails_rbi:models to regenerate.
# typed: strong

class User::Relation < ActiveRecord::Relation
  include User::NamedScope
  extend T::Generic
  Elem = type_member(fixed: User)
end

class User < ApplicationRecord
  extend T::Sig
  extend T::Generic
  extend User::NamedScope
  Elem = type_template(fixed: User)

  sig { returns(T.nilable(String)) }
  def code(); end

  sig { params(value: T.nilable(String)).void }
  def code=(value); end

  sig { returns(DateTime) }
  def created_at(); end

  sig { params(value: DateTime).void }
  def created_at=(value); end

  sig { returns(String) }
  def email(); end

  sig { params(value: String).void }
  def email=(value); end

  sig { returns(Event::Relation) }
  def events(); end

  sig { params(value: T.any(T::Array[Event], Event::Relation)).void }
  def events=(value); end

  sig { returns(String) }
  def first_name(); end

  sig { params(value: String).void }
  def first_name=(value); end

  sig { returns(Integer) }
  def id(); end

  sig { params(value: Integer).void }
  def id=(value); end

  sig { returns(Invite::Relation) }
  def invites(); end

  sig { params(value: T.any(T::Array[Invite], Invite::Relation)).void }
  def invites=(value); end

  sig { returns(String) }
  def last_name(); end

  sig { params(value: String).void }
  def last_name=(value); end

  sig { returns(Opportunity::Relation) }
  def opportunities(); end

  sig { params(value: T.any(T::Array[Opportunity], Opportunity::Relation)).void }
  def opportunities=(value); end

  sig { returns(String) }
  def password_digest(); end

  sig { params(value: String).void }
  def password_digest=(value); end

  sig { returns(T.nilable(String)) }
  def remember_digest(); end

  sig { params(value: T.nilable(String)).void }
  def remember_digest=(value); end

  sig { returns(T.nilable(String)) }
  def role(); end

  sig { params(value: T.nilable(String)).void }
  def role=(value); end

  sig { returns(DateTime) }
  def updated_at(); end

  sig { params(value: DateTime).void }
  def updated_at=(value); end

  sig { returns(Video::Relation) }
  def videos(); end

  sig { params(value: T.any(T::Array[Video], Video::Relation)).void }
  def videos=(value); end

end


module User::NamedScope
  extend T::Sig

  sig { returns(User::Relation) }
  def all(); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def select(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def order(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def reorder(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def group(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def limit(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def offset(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def joins(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def left_joins(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def left_outer_joins(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def where(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def rewhere(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def preload(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def eager_load(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def includes(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def from(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def lock(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def readonly(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def extending(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def or(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def having(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def create_with(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def distinct(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def references(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def none(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def unscope(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def merge(*args, block); end

  sig { params(args: T.untyped, block: T.nilable(T.proc.void)).returns(User::Relation) }
  def except(*args, block); end

end

