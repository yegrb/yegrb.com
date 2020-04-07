# typed: true
class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authorize_edit, only: %i[edit update destroy]

  # GET /events
  def index
    page = params[:page]
    @events = case params[:collection]
              when 'upcoming'
                Event.upcoming.paginate(page: page, per_page: 10).includes(:user)
              when 'past'
                Event.past.paginate(page: page, per_page: 10).includes(:user)
              else
                Event.sorted.paginate(page: page, per_page: 10).includes(:user)
              end
    authorize! :read, Event
  end

  # GET /events/1
  def show
    authorize! :read, @event
  end

  # GET /events/new
  def new
    @event = Event.new
    authorize! :new, @event
  end

  # GET /events/1/edit
  def edit; end

  # POST /events
  def create
    @event = Event.new(event_params)
    authorize! :create, @event
    if @event.save
      flash[:success] = 'Event was successfully created.'
      redirect_to @event
    else
      flash[:danger] = 'Unable to create event'
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      flash[:success] = 'Event was successfully updated.'
      redirect_to @event
    else
      flash.now[:danger] = 'Unable to update event.'
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    flash[:success] = 'Event was successfully destroyed.'
    redirect_to events_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_edit
    authorize! :edit, @event
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    event = params.require(:event).permit(:user_id, :title, :time, :location, :url, :content, :alt_location_url)
    current_user ? event.merge(user_id: T.must(current_user).id) : event
  end
end
