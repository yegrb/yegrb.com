class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]
  before_action :authorize_edit, only: [:edit, :update, :destroy]
  before_action :authorize_read, only: [:show]

  # GET /invites
  def index
    authorize! :read, Invite
    @invites = Invite.all
  end

  # GET /invites/1
  def show
  end

  # GET /invites/new
  def new
    @invite = Invite.new
    authorize! :edit, @invite
  end

  # GET /invites/1/edit
  def edit
  end

  # POST /invites
  def create
    @invite = Invite.new(invite_params)
    @invite.user_id = current_user.id
    if @invite.save
      flash[:success] = 'Invite was successfully created.'
      redirect_to @invite
    else
      render :new
    end
  end

  # PATCH/PUT /invites/1
  def update
    if @invite.update(invite_params)
      flash[:success] = 'Invite was successfully updated.'
      redirect_to @invite
    else
      render :edit
    end
  end

  # DELETE /invites/1
  def destroy
    @invite.destroy
    flash[:success] = 'Invite was successfully destroyed.'
    redirect_to invites_url
  end

  private

  def authorize_edit
    authorize! :edit, @invite
  end

  def authorize_read
    authorize! :read, @invite
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_invite
    @invite = Invite.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invite_params
    params.require(:invite).permit(:name, :email, :code, :expiry, :user_id, :role)
  end
end
