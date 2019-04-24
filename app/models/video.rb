# == Schema Information
#
# Table name: videos
#
#  id          :bigint(8)        not null, primary key
#  recorded_at :date
#  slides_url  :string
#  speaker     :string
#  speaker_url :string
#  summary     :text
#  title       :string
#  video_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  event_id    :integer
#  user_id     :integer
#

class Video < ApplicationRecord
  belongs_to :user
  belongs_to :event

  DATEPICKER_JS = {
    format: 'YYYY-MM-DD HH:mm',
    showTodayButton: true,
    icons: {
      time: 'fa fa-clock-o',
      date: 'fa fa-calendar',
      up: 'fa fa-arrow-up',
      down: 'fa fa-arrow-down',
      previous: 'fa fa-chevron-left',
      next: 'fa fa-chevron-right',
      today: 'fa fa-calendar-check-o',
      clear: 'fa fa-delete',
      close: 'fa fa-times'
    }
  }

  scope :sorted, -> { order('recorded_at DESC').includes(:user, :event) }

  validates :user_id, presence: true
  validates :recorded_at, presence: true
  validates :speaker, presence: true
  validates :summary, presence: true, length: { within: 20..1000 }
  validates :title, presence: true, length: { maximum: 30 }


  def to_s
    "#{title}, #{speaker}"
  end

  def nice_created_at
    created_at.strftime('%d %b %Y')
  end
end
