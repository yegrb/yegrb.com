class OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy]
  before_action :authorize_edit, only: [:edit, :update, :destroy]
  before_action :authorize_read, only: [:show]

  # GET /opportunities
  def index
    @opportunities = Opportunity.all
  end

  # GET /opportunities/1
  def show
  end

  # GET /opportunities/new
  def new
    @opportunity = Opportunity.new
    authorize! :edit, Opportunity
  end

  # GET /opportunities/1/edit
  def edit
  end

  # POST /opportunities
  def create
    @opportunity = Opportunity.new(opportunity_params)
    authorize! :edit, @opportunity
    if @opportunity.save
      flash[:success] = 'Opportunity was successfully created.'
      redirect_to @opportunity
    else
      flash.now[:danger] = 'Unable to create opportunity.'
      render :new
    end
  end

  # PATCH/PUT /opportunities/1
  def update
    if @opportunity.update(opportunity_params)
      flash[:success] = 'Opportunity was successfully updated.'
      redirect_to @opportunity, notice: 'Opportunity was successfully updated.'
    else
      flash.now[:danger] = 'Unable to update opportunity'
      render :edit
    end
  end

  # DELETE /opportunities/1
  def destroy
    @opportunity.destroy
    flash[:success] = 'Opportunity was successfully destroyed.'
    redirect_to opportunities_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def authorize_edit
    authorize! :edit, @opportunity
  end

  def authorize_read
    authorize! :read, @opportunity
  end

  def set_opportunity
    @opportunity = Opportunity.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def opportunity_params
    params.require(:opportunity).permit(:user_id, :title, :company, :contact, :email, :paid_position, :content, :good_until)
  end
end
