class AuthenticationController < ApplicationController
  def login
    @user = User.find_by(params[:email])

    if @user.authenticate(params[:password])
      token = JsonWebToken.jwt_encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Correo o contraseña inválidos' }, status: :unauthorized
    end
  end
end
