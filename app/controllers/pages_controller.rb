class PagesController < ApplicationController
  def index
    @event = Event.upcoming.first
    @opportunity = Opportunity.open.first
    @video = Video.sorted.first
  end

  def aboutus; end

  def opportunities; end

  def getinvolved
    @message = Message.new
  end

  def resources; end
end
