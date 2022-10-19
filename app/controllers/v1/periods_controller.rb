# frozen_string_literal:true

module V1
  class PeriodsController < ApplicationController
    include ErrorHandler

    before_action :find_period, only: %i[show update destroy]
    before_action :set_period, only: %i[create]

    rescue_from StandardError, with: :render_exception

    def index
      @periods = if @current_user.role == 'admin'
                   Period.all.order('start_date DESC')
                 else
                   Period
                     .filter_by_company(@current_user.company.id)
                     .order('start_date DESC')
                 end
    end

    def show
      render :show, status: :ok
    end

    def create
      if %w[admin accountant].include?(@current_user.role)
        if @period.save
          render :show, status: :created
        else
          @errors = @period.errors
          render_error
        end
      else
        render_unauthorized
      end
    end

    def update
      if %w[admin accountant].include?(@current_user.role)
        if @period.update(period_params)
          render :show, status: :ok
        else
          @errors = @period.errors
          render_error
        end
      else
        render_unauthorized
      end
    end

    def destroy
      if %w[admin accountant].include?(@current_user.role)
        @period.destroy

        head :no_content
      else
        render_unauthorized
      end
    end

    private

    def set_period
      @period = Period.new(period_params)
    end

    def find_period
      @period = if @current_user == 'admin'
                  Period.find_by(id: params[:id])
                else
                  Period
                    .filter_by_company(@current_user.company.id)
                    .find_by(id: params[:id])
                end
    end

    def period_params
      # params.require(:period).permit(:start_date, :end_date, :state, :company_nit)
      {
        start_date: params[:period][:start_date],
        end_date: params[:period][:end_date],
        state: params[:period][:state],
        company_id: Company.find_by(nit: params[:period][:company_nit]).id
      }
    end
  end
end
