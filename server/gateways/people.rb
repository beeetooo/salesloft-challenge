require 'faraday'

module Application
  module People
    class GatewayError < StandardError; end
    class InternalServerError < StandardError; end
    class Unauthorized < GatewayError; end
    class UnexpectedResponse < GatewayError; end

    class Gateway
      GET_URL = 'https://api.salesloft.com/v2/people.json?'.freeze

      def initialize(api_token)
        @api_token = api_token
        @connection = Faraday.new do |connection|
          connection.adapter Faraday.default_adapter
        end
      end

      def get(page: 1, per_page: 25)
        response = @connection.get(
          GET_URL,
          { page: page, per_page: per_page },
          { Authorization: "Bearer #{@api_token}" }
        )

        if error? response
          raise Unauthorized if unauthorized? response
          raise InternalServerError if server_error? response

          raise GatewayError
        end

        begin
          json = JSON.parse response.body
          parse json['data']
        rescue JSON::ParserError
          raise UnexpectedResponse
        end
      end

      def all
        response = @connection.get(
          GET_URL,
          { page: 1, per_page: 375 },
          { Authorization: "Bearer #{@api_token}" }
        )

        if error? response
          raise Unauthorized if unauthorized? response
          raise InternalServerError if server_error? response

          raise GatewayError
        end

        begin
          json = JSON.parse response.body
          parse json['data']
        rescue JSON::ParserError
          raise UnexpectedResponse
        end
      end

      private

      def parse(people)
        people.map do |person|
          {
            id: person['id'],
            name: person['display_name'],
            email: person['email_address'],
            title: person['title']
          }
        end
      end

      def error?(response)
        response.status >= 400
      end

      def unauthorized?(response)
        response.status == 401
      end

      def server_error?(response)
        response.status == 500
      end
    end
  end
end
