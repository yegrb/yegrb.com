# == Schema Information
#
# Table name: invites
#
#  id         :bigint(8)        not null, primary key
#  code       :string
#  email      :string
#  expiry     :datetime
#  name       :string
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
