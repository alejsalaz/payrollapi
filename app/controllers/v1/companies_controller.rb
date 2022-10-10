module V1
  class CompaniesController < ApplicationController
    before_action :set_company, only: %i[show update destroy]

    def index
      @company = @current_user.company
      render json: @company, status: :ok
    end

    def show
      render json: @company, status: :ok
    end

    def create
      @company = Company.new(company_params)

      if @company.save
        render json: @company, status: :created
      else
        @errors = @company.errors
        render template: 'v1/error', status: :unprocessable_entity
      end
    end

    def update
      if @company.update(company_params)
        render json: @company, status: :ok
      else
        @errors = @company.errors
        render template: 'v1/error', status: :unprocessable_entity
      end
    end

    def destroy
      @company.destroy

      head :no_content
    end

    private

    def set_company
      @company = Company.find_by_id(@current_user.company.id)
    end

    def company_params
      # TODO: Set this to allow form-data
      params.require(:company).permit(:nit, :legal_name, :display_name)
    end
  end
end
