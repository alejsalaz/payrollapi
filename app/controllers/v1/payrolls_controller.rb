# frozen_string_literal:true

module V1
  class PayrollsController < ApplicationController
    include ErrorHandler
    # TODO: make this work
    include PaymentHelper

    before_action :find_payroll, only: %i[show update destroy]

    rescue_from StandardError, with: :render_exception

    def index
      @payrolls = case @current_user.role
                  when 'admin'
                    Payroll.all.order('created_at ASC')
                  when 'accountant'
                    Payroll
                  .joins(:period).where(periods: { company_id: Company.find_by(id: @current_user.company.id) })
                  .order('created_at DESC')
                  else
                    # TODO: an account should always belong to an employee
                    Payroll
                  .joins(:employee).where(employee: { full_name: @current_user.full_name })
                  .order('created_at DESC')
                  end
    end

    def show
      render :show, status: :ok
    end

    def create
      if %w[admin accountant].include?(@current_user.role)
        begin
          remunerate
          render :index, status: :created
        rescue StandardError => e
          render json: { error: { problema: e } }, status: :unprocessable_entity
        end
      else
        render_unauthorized
      end
    end

    def update
      if %w[admin accountant].include?(@current_user.role)
        if @payroll.update(payroll_params)
          render :show, status: :ok
        else
          @errors = @payroll.errors
          render_error
        end
      else
        render_unauthorized
      end
    end

    def destroy
      if %w[admin accountant].include?(@current_user.role)
        @payroll.destroy

        head :no_content
      else
        render_unauthorized
      end
    end

    private

    def find_payroll
      @payroll = case @current_user.role
                 when 'admin'
                   Payroll
                 .all
                 .find_by(id: params[:id])
                 when 'accountant'
                   Payroll
                 .joins(:period).where(periods: { company_id: @current_user.company.id })
                 .find_by(id: params[:id])
                 else
                   # TODO: an account should always belong to an employee
                   Payroll
                 .joins(:employee).where(employee: { full_name: @current_user.full_name })
                 .find_by(id: params[:id])
                 end
    end

    def payroll_params
      {
        employee_id: Employee.find_by(card_id: params[:payroll][:employee]).id,
        period_id: Period.find_by(start_date: params[:payroll][:period]).id,
        salary_income: params[:payroll][:salary_income],
        non_salary_income: params[:payroll][:non_salary_income],
        deduction: params[:payroll][:deduction]
      }
    end
  end
end
