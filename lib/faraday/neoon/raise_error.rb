module Faraday
  module Neoon
    class RaiseError < Faraday::Response::Middleware

      def call(env)
        @app.call(env).on_complete do |env|
          case env[:status]
          when (400..499)
            raise "Neoon::Error::#{JSON.parse(env[:body])["cause"]["exception"]}".constantize.new(env[:response], env[:response].body)
          when (500..599)
            raise 'Something went error with Neo4j server.'
          end
        end
      end

    end
  end
end
