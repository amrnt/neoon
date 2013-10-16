module Neoon
  module Client
    module Request

      def cypher(query, parameters = {})
        options = { :query => query, :params => parameters }
        post('/cypher', options)
      end
      alias_method :q, :cypher

      %w(get post put delete).each do |action|
        define_method(action) do |path, options = {}|
          make_request(action.to_sym, '/db/data' + path, options)
        end
      end

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