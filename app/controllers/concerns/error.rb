module Error

  module ErrorHandler

    def self.included(clazz)

      clazz.class_eval do

        rescue_from ActiveRecord::RecordNotFound do |e|
          respond(:record_not_found, 404, e.to_s)
        end
        rescue_from ActiveRecord::RecordInvalid do |e|
          respond(:record_invalid, 422, e.to_s)
        end
        rescue_from ActiveRecord::RecordNotUnique do |e|

        end
        rescue_from CustomError do |e|
          respond(e.error, e.status, e.message)
        end
      end
    end

    private

    def respond(_error, _status, _message)
      render json: {
          error: _error,
          status: _status,
          message: _message
      }
      # flash.notice = "Error: #{_message}"
      # redirect_to(request.referrer)
    end
  end


  class CustomError < StandardError
    attr_reader :status, :error, :message

    def initialize(_error=nil, _status=nil, _message=nil)
      @error = _error || 422
      @status = _status || :unprocessable_entity
      @message = _message || 'Something went wrong'
    end

  end

end