class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_edit, only: %i[edit update destroy]
  before_action :authorize_read, only: [:show]

  # GET /users
  def index
    authorize! :read_all, User
    @users = User.all
  end

  # GET /users/1
  def show; end

  # GET /users/new
  def new
    @invite = Invite.find_by(code: params[:code])
    if @invite
      @user = User.new
      @user.email = @invite.email
      @user.role = @invite.role
      @user.code = @invite.code
    else
      flash.now[:danger] = 'Sorry, this code is invalid.'
      redirect_to root_path
    end
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  def create
    @user = User.new(user_params)
    @invite = Invite.find_by(code: params[:user][:code])
    @user.email = @invite&.email
    @user.role = @invite&.role
    authorize! :use, @invite
    authorize! :signup, @user
    if @invite.expired?
      flash.now[:danger] = 'Sorry, this invitation has expired.'
      redirect_to root_path
    elsif @invite && @user.save
      @invite.destroy!
      flash[:success] = 'User was successfully created.'
      redirect_to @user
    else
      flash.now[:danger] = 'Could not create user'
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      flash[:success] = 'User was successfully updated.'
      redirect_to @user
    else
      flash.now[:danger] = 'Could not update user'
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    flash[:success] = 'User was successfully destroyed.'
    redirect_to users_url
  end

  private

  def authorize_edit
    authorize! :edit, @user
  end

  def authorize_read
    authorize! :read, @user
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation)
  end
end
