module V1
  class CompaniesController < ApplicationController
    before_action :set_company, only: %i[show update destroy]

    def index
      @companies = Company.order(:legal_name)
      render json: @companies, status: :ok
    end

    def show
      render json: @company, status: :ok
    end

    def create
      @company = Company.new(company_params)

      if @company.save
        render json: @company, status: :created
      else
        render json: @company.errors, status: :unprocessable_entity
      end
    end

    def update
      if @company.update(company_params)
        render json: @company, status: :ok
      else
        render json: @company.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @company.destroy

      head :no_content
    end

    private

    def set_company
      @company = Company.find[params[:id]]
    end

    def company_params
      params.require(:company).permit(:nit, :legal_name, :display_name)
    end
  end
end
