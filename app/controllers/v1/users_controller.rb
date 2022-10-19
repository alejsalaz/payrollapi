# frozen_string_literal:true

module V1
  class UsersController < ApplicationController
    include ErrorHandler

    before_action :find_user, only: %i[show update destroy]
    before_action :set_user, only: [:create]

    rescue_from StandardError, with: :render_exception

    def index
      @users = if @current_user.role == 'admin'
                 User.all.order('email')
               else
                 User
                   .filter_by_company(@current_user.company.id)
                   .order('email')
               end

      render :index, status: :ok
    end

    def show
      if @user.present?
        render :show, status: :ok
      else
        render_unauthorized
      end
    end

    def create
      # TODO: This should be a sign in and only employees can sign in
      if %w[admin accountant].include?(@current_user.role)
        if @user.save
          render :show, status: :created
        else
          @errors = @user.errors
          render_error
        end
      else
        render_unauthorized
      end
    end

    def update
      if %w[admin accountant].include?(@current_user.role)
        if @user.update(check_params)
          render :show, status: :ok
        else
          @errors = @user.errors
          render_error
        end
      else
        render_unauthorized
      end
    end

    def destroy
      if %w[admin accountant].include?(@current_user.role)
        @user.destroy

        head :no_content
      else
        render_unauthorized
      end
    end

    private

    def check_params
      case @current_user.role
      when 'admin'
        user_params
      when 'accountant'
        user_params.tap { |param| param.delete(:role) }
      end
    end

    def set_user
      @user = User.new(check_params)
    end

    def find_user
      @user = if @current_user.role == 'admin'
                User.find_by_id([params[:id]])
              else
                User
                  .filter_by_company(@current_user.company.id)
                  .find_by_id([params[:id]])
              end
    end

    def user_params
      params.require(:user).permit(:full_name, :email, :password, :company_id, :role)
    end
  end
end
