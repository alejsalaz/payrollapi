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
    post '/v1/auth/login',
         params: {
           email: user[:email],
           password: 'K0qLnU56c948V'
         }, as: :json

    parse_response_body(response)['datos']['token']
  end

  private

  def parse_response_body(response)
    JSON.parse(response.body)
  end
end
