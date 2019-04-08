# == Schema Information
#
# Table name: videos
#
#  id         :bigint(8)        not null, primary key
#  link       :string
#  speaker    :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Video < ApplicationRecord
end
