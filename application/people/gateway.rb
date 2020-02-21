module Application
  module People
    class GatewayError < StandardError; end
    class InternalServerError < StandardError; end
    class Unauthorized < GatewayError; end
    class UnexpectedResponse < GatewayError; end

    class Gateway
      GET_URL = 'https://api.salesloft.com/v2/people.json?'

      def initialize(api_token)
        @api_token = api_token
      end

      def get(page: 1, per_page: 25)
        response = Faraday.get(
          GET_URL,
          { page: page, per_page: per_page },
          { Authorization: @api_token }
        )

        if error? response
          raise Unauthorized if unauthorized? response
          raise InternalServerError if server_error? response

          raise GatewayError
        end

        begin
          parse response.body
        rescue
          raise UnexpectedResponse
        end
      end

      def parse(people)
        people.map do |person|
          {
            id: person[:id],
            name: person[:display_name],
            email: person[:email_address],
            title: person[:title],
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
