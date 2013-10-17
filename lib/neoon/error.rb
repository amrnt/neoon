module Neoon
  module Error
    class Exception < StandardError
      attr_reader :response

      def initialize(response, message = response.body)
        @response = response
        super(message)
      end
    end

    class ClientError < Exception; end
    class ServerError < Exception; end
    class NotFoundError < Exception; end
  end
end
