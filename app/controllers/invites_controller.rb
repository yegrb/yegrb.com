class InvitesController < ApplicationController
  before_action :set_invite, only: [:show, :edit, :update, :destroy]
  before_action :authorize_edit, only: [:destroy]

  # GET /invites
  def index
    authorize! :read, Invite
    @invites = Invite.all
  end

  # GET /invites/new
  def new
    @invite = Invite.new
    authorize! :edit, @invite
  end

  # POST /invites
  def create
    @invite = Invite.new(invite_params)
    authorize! :edit, @invite
    @invite.user_id = current_user.id
    if @invite.save
      flash[:success] = 'Invite was successfully created.'
      redirect_to @invite
    else
      flash.now[:danger] = 'Invite could not be created.'
      render :new
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

  # Use callbacks to share common setup or constraints between actions.
  def set_invite
    @invite = Invite.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invite_params
    params.require(:invite).permit(:name, :email, :role)
  end
end
