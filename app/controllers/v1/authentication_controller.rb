module V1
  class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request, only: [:login]

    def login
      @user = User.find_by_email(params[:email])

      if @user.authenticate(params[:password])
        token = jwt_encode(user_id: @user.id)
        render json: { datos: { token: token } }, status: :ok
      else
        render json: { error: 'Correo o contraseña inválidos' }, status: :unauthorized
      end
    end
  end
end
