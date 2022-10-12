# frozen_string_literal: true

module AuthorizationHelper
  def login(user)
    post '/v1/auth/login',
         params: {
           email: user[:email],
           password: 'K0qLnU56c948V'
         },
         as: :json
  end

  def auth_tokens_for_user(user)
    post '/v1/auth/sign_in/',
         params: { email: user[:email], password: user[:password] },
         as: :json
    response.headers.slice('client', 'access-token', 'uid')
  end
end
