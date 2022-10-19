# frozen_string_literal: true

module V1
  class EmployeesController < ApplicationController
    include ErrorHandler

    before_action :find_employee, only: %i[show update destroy]
    before_action :set_employee, only: [:create]

    rescue_from StandardError, with: :render_exception

    def index
      @employees = if @current_user.role == 'admin'
                     Employee.all.order('full_name')
                   else
                     Employee
                       .filter_by_company(@current_user.company.id)
                       .order('full_name')
                   end

      render :index, status: :ok
    end

    def show
      if @employee.present?
        render :show, status: :ok
      else
        render_unauthorized
      end
    end

    def create
      if %w[admin accountant].include?(@current_user.role)
        if @employee.save
          render :show, status: :created
        else
          @errors = @employee.errors
          render_error
        end
      else
        render_unauthorized
      end
    end

    def update
      if %w[admin accountant].include?(@current_user.role)
        if @employee.update(check_params)
          render :show, status: :ok
        else
          @errors = @employee.errors
          render_error
        end
      else
        render_unauthorized
      end
    end

    def destroy
      if %w[admin accountant].include?(@current_user.role)
        @employee.destroy

        head :no_content
      else
        render_unauthorized
      end
    end

    private

    # TODO: employee missing key shouldn't be allowed
    def check_params
      {
        card_id: params[:employee][:card_id],
        company_id: Company.find_by(nit: params[:employee][:company_nit]).id,
        full_name: params[:employee][:full_name],
        risk_class: params[:employee][:risk_class],
        job_title: params[:employee][:job_title],
        base_salary: params[:employee][:base_salary],
        start_date: params[:employee][:start_date],
        termination_date: params[:employee][:termination_date],
        contract_type: params[:employee][:contract_type]
      }
    end

    def set_employee
      @employee = Employee.new(check_params)
    end

    def find_employee
      @employee = if @current_user.role == 'admin'
                    Employee.find_by(card_id: [params[:id]])
                  else
                    Employee
                      .filter_by_company(@current_user.company.id)
                      .find_by(card_id: [params[:id]])
                  end
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:card_id, :company_nit, :full_name, :risk_class, :job_title, :base_salary,
                                       :start_date, :termination_date, :contract_type)
    end
  end
end
