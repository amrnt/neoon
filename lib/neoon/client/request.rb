module Neoon
  module Client
    module Request

      def cypher(query, parameters = {})
        options = { :query => query, :params => parameters }
        post('/cypher', options)
      end
      alias_method :q, :cypher

      def get(path, options={})
        make_request(:get, '/db/data' + path, options)
      end

      def post(path, options={})
        make_request(:post, '/db/data' + path, options)
      end

      def put(path, options={})
        make_request(:put, '/db/data' + path, options)
      end

      def delete(path, options={})
        make_request(:delete, '/db/data' + path, options)
      end

    private

      def make_request(method, path, options)
        response = connection.send(method) do |request|
          case method
          when :get, :delete
            request.url(path, options)
          when :post, :put
            request.path = path
            request.body = options unless options.empty?
          end
        end
        response.body
      end

    end
  end
end