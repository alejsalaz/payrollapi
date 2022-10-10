module V1
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]

    def index
      @users = User
               .filter_by_company(@current_user.company.id)
               .order('email')
      render json: @users, status: :ok
    end

    def show
      render json: @user, status: :ok
    end

    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created
      else
        @errors = @user.errors
        render template: 'error', status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        render json: @user, status: :ok
      else
        @errors = @user.errors
        render template: 'error', status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy

      head :no_content
    end

    private

    def set_user
      @user = User.find_by_id([params[:id]])
    end

    def user_params
      params.require(:user).permit(:full_name, :email, :password, :company_id)
    end
  end
end
