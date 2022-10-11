# frozen_string_literal:true

module V1
  class CompaniesController < ApplicationController
    before_action :find_company, only: %i[show update destroy]
    before_action :set_company, only: %i[create]

    VERSION = 'v1'

    def index
      if @current_user.role == 'admin'
        @companies = Company.all.order('legal_name')
        render :index, status: :ok
      else
        render template: "#{VERSION}/unauthorized", status: :unauthorized
      end
    end

    def show
      render :show, status: :ok
    end

    def create
      if @current_user.role == 'admin'
        if @company.save
          render :show, status: :created
        else
          @errors = @company.errors
          render template: "#{VERSION}/error", status: :unprocessable_entity
        end
      else
        render template: "#{VERSION}/unauthorized", status: :unauthorized
      end
    end

    def update
      if %w[admin accountant].include?(@current_user.role)
        if @company.update(company_params)
          render :show, status: :ok
        else
          @errors = @company.errors
          render template: "#{VERSION}/error", status: :unprocessable_entity
        end
      else
        render template: "#{VERSION}/unauthorized", status: :unauthorized
      end
    end

    def destroy
      if @current_user.role == 'admin'
        @company.destroy

        head :no_content
      else
        render template: "#{VERSION}/unauthorized", status: :unauthorized
      end
    end

    private

    def set_company
      @company = Company.new(company_params)
    end

    def find_company
      @company = if @current_user == 'admin'
                   Company.find_by_nit(params[:nit])
                 else
                   Company.find_by_nit(@current_user.company.nit)
                 end
    end

    def company_params
      params.require(:company).permit(:nit, :legal_name, :display_name)
    end
  end
end
