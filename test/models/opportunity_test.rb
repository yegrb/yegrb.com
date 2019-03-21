# == Schema Information
#
# Table name: opportunities
#
#  id            :bigint(8)        not null, primary key
#  company       :string
#  contact       :string
#  content       :text
#  email         :string
#  good_until    :datetime
#  paid_position :boolean
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer
#

require 'test_helper'

class OpportunityTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
