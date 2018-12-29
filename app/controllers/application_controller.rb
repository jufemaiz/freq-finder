# frozen_string_literal: true

# [ApplicationController]
#
# @since 20181220
# @author Joel Courtney <joel@aceteknologi.com>
class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    head 404
  end
end
