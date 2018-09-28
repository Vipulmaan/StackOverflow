class ErrorsController < ApplicationController


  def route_not_found
    render json: {
        status: 406,
        error: :route_not_found,
        message: 'No Route Match'
    }, status: 406
  end

  def not_found
    render json: {
        status: 404,
        error: :not_found,
        message: 'Where did the 403 errors go'
    }, status: 404
  end

  def internal_server_error
    render json: {
        status: 500,
        error: :internal_server_error,
        message: 'Houston we have a problem'
    }, status: 500
  end

  def show
    render action: request.path[1..-1 ]
  end
end
