# == Schema Information
#
# Table name: events
#
#  id          :bigint(8)        not null, primary key
#  content     :text
#  location    :string
#  signup_link :string
#  time        :datetime
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
