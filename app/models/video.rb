# typed: true
# == Schema Information
#
# Table name: videos
#
#  id          :bigint(8)        not null, primary key
#  content_url :string
#  recorded_at :date
#  runtime     :integer
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
  extend T::Sig

  belongs_to :user
  belongs_to :event

  DATEPICKER_JS = {
    format: 'YYYY-MM-DD',
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

  scope :sorted, -> { order('recorded_at DESC') }

  validates :user_id, presence: true
  validates :recorded_at, presence: true
  validates :runtime, presence: true
  validates :speaker, presence: true
  validates :summary, presence: true, length: { within: 20..1000 }
  validates :title, presence: true, length: { maximum: 50 }

  sig { returns(String) }
  def to_s
    "#{title}, #{speaker}"
  end

  sig { returns(String) }
  def nice_created_at
    created_at.strftime('%d %b %Y')
  end

  sig { returns(String) }
  def nice_recorded_at
    T.must(recorded_at).strftime('%d %b %Y')
  end

  sig { returns(String) }
  def youtube_id
    T.must(video_url).scan(/v=([^&]+)/).flatten.first || ''
  end
end
