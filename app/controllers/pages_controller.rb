class PagesController < ApplicationController
  def index
    @event = Event.upcoming.first
    @opportunity = Opportunity.open.first
  end

  def aboutus
  end

  def opportunities
  end

  def getinvolved
  end

  def resources
  end
end
