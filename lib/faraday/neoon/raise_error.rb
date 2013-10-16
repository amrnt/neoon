module Faraday
  module Neoon
    class RaiseError < Faraday::Response::Middleware

      def call(env)
        @app.call(env).on_complete do |env|
          case env[:status]
          when 404
            raise ::Neoon::Error::NotFoundError.new(env[:response])
          when (400..499)
            raise ::Neoon::Error::ClientError.new(env[:response])
          when (500..599)
            raise ::Neoon::Error::ServerError.new(env[:response])
          end
        end
      end

    end
  end
end
