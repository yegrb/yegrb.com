# typed: true
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_edit, only: %i[edit update destroy]

  # GET /users
  def index
    authorize! :read_all, User
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  def show
    authorize! :read, @user
  end

  # GET /users/new
  def new
    if (invite = Invite.find_by(code: params[:code]))
      @user = User.new(email: invite.email, role: invite.role, code: invite.code)
    else
      flash.now[:danger] = 'Sorry, this code is invalid.'
      redirect_to root_path
    end
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  def create
    code = params.dig(:user, :code)

    if code && (invite = Invite.find_by(code: code))
      authorize! :use, invite

      @user = User.new(user_params.merge(email: invite.email, role: invite.role))
      authorize! :signup, @user

      if invite.expired?
        reject_to_root 'Sorry, this invitation has expired.'
      elsif @user.save
        invite.destroy!
        flash[:success] = 'User was successfully created.'
        redirect_to @user
      else
        flash.now[:danger] = 'Could not create user'
        render :new
      end
    else
      reject_to_root 'Invalid invitation'
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

  def reject_to_root(text)
    flash[:danger] = text
    redirect_to root_path
  end

  def authorize_edit
    authorize! :edit, @user
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
