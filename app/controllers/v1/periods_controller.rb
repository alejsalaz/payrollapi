class PeriodsController < ApplicationController
  before_action :set_period, only: %i[show update destroy]

  # GET /periods
  # GET /periods.json
  def index
    @periods = Period.all
  end

  # GET /periods/1
  # GET /periods/1.json
  def show; end

  # POST /periods
  # POST /periods.json
  def create
    @period = Period.new(period_params)

    if @period.save
      render :show, status: :created, location: @period
    else
      render json: @period.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /periods/1
  # PATCH/PUT /periods/1.json
  def update
    if @period.update(period_params)
      render :show, status: :ok, location: @period
    else
      render json: @period.errors, status: :unprocessable_entity
    end
  end

  # DELETE /periods/1
  # DELETE /periods/1.json
  def destroy
    @period.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_period
    @period = Period.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def period_params
    params.require(:period).permit(:run_state, :start_date, :end_date)
  end
end
