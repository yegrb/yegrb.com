# == Schema Information
#
# Table name: invites
#
#  id         :bigint(8)        not null, primary key
#  code       :string
#  email      :string
#  expiry     :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Invite < ApplicationRecord
end
