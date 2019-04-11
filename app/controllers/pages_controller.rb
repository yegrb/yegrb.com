class PagesController < ApplicationController
  def index
    @event = Event.upcoming.first
  end

  def about
  end

  def contact
  end

  def opportunities
  end

  def slack
  end

  def resources
  end
end
