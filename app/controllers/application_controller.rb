class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActionController::ParameterMissing, with: :render_bad_request

  private

  def render_not_found(exception)
    logger.warn "Resource not found: #{exception.message}"
    render json: { error: "Resource not found" }, status: :not_found
  end

  def render_unprocessable_entity(exception)
    logger.warn "Validation failed: #{exception.record.errors.full_messages}"
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def render_bad_request(exception)
    logger.warn "Parameter missing: #{exception.param}"
    render json: { error: "Parameter missing: #{exception.param}" }, status: :bad_request
  end
end
