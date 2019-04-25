class VideosController < ApplicationController
  before_action :set_video, only: %i[show edit update destroy]
  before_action :authorize_edit, only: %i[edit update destroy]

  # GET /videos
  def index
    @videos = Video.sorted.paginate(page: params[:page], per_page: 10)
    authorize! :read, Video
  end

  # GET /videos/1
  def show
    authorize! :read, @video
  end

  # GET /videos/new
  def new
    @video = Video.new
    authorize! :edit, @video
  end

  # GET /videos/1/edit
  def edit
    authorize! :edit, @video
  end

  # POST /videos
  def create
    @video = Video.new(video_params)
    @video.user_id = current_user&.id
    authorize! :create, @video

    if @video.save
      flash[:success] = 'Video was successfully created.'
      redirect_to @video
    else
      flash[:danger] = 'Unable to create video'
      render :new
    end
  end

  # PATCH/PUT /videos/1
  def update
    if @video.update(video_params)
      flash[:success] = 'Video was successfully updated.'
      redirect_to @video
    else
      flash.now[:danger] = 'Unable to update video.'
      render :edit
    end
  end

  # DELETE /videos/1
  def destroy
    @video.destroy
    flash[:success] = 'Event was successfully destroyed.'
    redirect_to videos_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_video
    @video = Video.find(params[:id])
  end

  def authorize_edit
    authorize! :edit, @video
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def video_params
    params.require(:video).permit(
      :video_url,
      :slides_url,
      :speaker_url,
      :recorded_at,
      :title,
      :speaker,
      :summary,
      :event_id,
      :user_id,
      :runtime
    )
  end
end
