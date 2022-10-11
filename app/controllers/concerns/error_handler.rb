# frozen_string_literal: true

module ErrorHandler
  extend ActiveSupport::Concern

  VERSION = 'v1'

  def render_unauthorized
    render template: "#{VERSION}/unauthorized", status: :unauthorized
  end

  def render_error
    render template: "#{VERSION}/error", status: :unprocessable_entity
  end

  def render_exception(exception = nil)
    render json: { error: { problema: exception.message } }, status: :bad_request if exception
  end
end
