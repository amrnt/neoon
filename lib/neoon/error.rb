module Neoon
  module Error

    class Exception < StandardError
      attr_reader :response

      def initialize(response)
        @response = response
        super(response)
      end
    end

    class ClientError < Exception; end
    class ServerError < Exception; end
    class NotFoundError < Exception; end

  end
end
