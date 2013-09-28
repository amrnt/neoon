module Faraday
  module Neoon
    class RaiseError < Faraday::Response::Middleware

      def call(env)
        @app.call(env).on_complete do |env|
          case env[:status]
          when (400..499)
            body = JSON.parse(env[:body])
            raise Object.const_get("Neoon::Error::#{body["cause"]["exception"]}"), "#{{
              :message => body["message"],
              :exception => body["exception"],
              :cause => {
                :message => body["cause"]["message"],
                :exception => body["cause"]["exception"]
              }
            } if env[:body]}"
          when (500..599)
            raise 'Something went error with Neo4j server.'
          end
        end
      end

    end
  end
end
