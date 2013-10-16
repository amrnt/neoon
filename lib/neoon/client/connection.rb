module Neoon
  module Client
    class Connection

      include Request
      attr_reader :connection

      def initialize(url)
        uri = URI.parse(url)
        end_point = "#{uri.scheme}://#{uri.host}:#{uri.port}#{uri.path}"
        @connection ||= Faraday.new(end_point, connection_options.merge(:builder => middleware))
        @connection.basic_auth(uri.user, uri.password) if uri.user && uri.password
      end

    private

      def connection_options
        @connection_options ||= { :headers => {
          :accept => 'application/json',
          :content_type => 'application/json; charset=UTF-8',
          :x_stream => 'true',
          :user_agent => ['Neoon', Neoon::VERSION].join(' ') },
          :request => {
            :open_timeout => 5,
            :timeout => 10 }
        }
      end

      def middleware
        @middleware ||= Faraday::Builder.new do |builder|
          builder.use FaradayMiddleware::EncodeJson
          builder.use FaradayMiddleware::Mashify
          builder.use FaradayMiddleware::ParseJson, :content_type => /\bjson$/
          builder.use Faraday::Neoon::RaiseError
          builder.adapter Faraday.default_adapter
        end
      end

    end
  end
end