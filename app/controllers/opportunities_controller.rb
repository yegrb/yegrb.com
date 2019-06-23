# typed: true
class OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: %i[show edit update destroy close]
  before_action :authorize_edit, only: %i[edit update destroy close]

  # GET /opportunities
  def index
    page = params[:page]
    @opportunities = case params[:collection]
                     when 'open'
                       Opportunity.open.paginate(page: page, per_page: 10).includes(:user)
                     when 'closed'
                       Opportunity.closed.paginate(page: page, per_page: 10).includes(:user)
                     else
                       Opportunity.sorted.paginate(page: page, per_page: 10).includes(:user)
                     end
    authorize! :read, Opportunity
  end

  # GET /opportunities/1
  def show
    authorize! :read, @opportunity
  end

  # GET /opportunities/new
  def new
    @opportunity = Opportunity.new
    @opportunity.good_until = Time.zone.now
    authorize! :new, @opportunity
  end

  # GET /opportunities/1/edit
  def edit; end

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
      redirect_to @opportunity
    else
      flash.now[:danger] = 'Unable to update opportunity'
      render :edit
    end
  end

  # PATCH/PUT /opportunities/1
  def close
    if @opportunity.close!
      flash[:success] = 'Opportunity was successfully closed.'
      redirect_to @opportunity
    else
      flash.now[:danger] = 'Unable to close opportunity'
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

  def set_opportunity
    @opportunity = Opportunity.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def opportunity_params
    opportunity = params.require(:opportunity).permit(
      :user_id, :title, :company, :contact, :email, :paid_position, :content, :good_until
    )
    current_user ? opportunity.merge(user_id: T.must(current_user).id) : opportunity
  end
end
