# frozen_string_literal: true

# [GraphqlController]
#
# @since 20181221
# @author Joel Courtney <joel@aceteknologi.com>
class GraphqlController < ApplicationController
  # Exectus things
  #
  # @return [void]
  def execute
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      # Query context goes here, for example:
      # current_user: current_user,
    }
    result = FreqFinderSchema.execute(query, variables:, context:, operation_name:)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?

    handle_error_in_development(e)
  end

  private

  # Handle form data, JSON body, or a blank value
  #
  # @param [Hash] ambiguous_param
  # @return [Hash]
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      if ambiguous_param.present?
        ensure_hash(JSON.parse(ambiguous_param))
      else
        {}
      end
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  # handle_error_in_development
  #
  # @param [Error] error
  def handle_error_in_development(error)
    logger.error(error.message)
    logger.error(error.backtrace.join("\n"))

    render json: {
      error: {
        message: error.message,
        backtrace: error.backtrace
      },
      data: {}
    }, status: 500
  end
end
