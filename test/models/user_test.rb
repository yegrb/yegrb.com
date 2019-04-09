# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  code            :string
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  role            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
