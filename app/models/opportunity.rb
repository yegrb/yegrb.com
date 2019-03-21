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

class Opportunity < ApplicationRecord
  belongs_to :user

  # Attributes
  # user_id:                  integer
  # title:                    string
  # company:                  string
  # contact:                  string
  # email:                    string
  # paid_position:            boolean
  # content:                  text
  # good_until:               datetime
  # created_at, updated_at:   datetime


end
