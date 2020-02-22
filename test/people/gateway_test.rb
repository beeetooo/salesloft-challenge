require 'test_helper'
require 'json'

require 'application/people/gateway'

module Application
  module People
    class GatewayTest < Minitest::Test
      TEST_URL = 'https://api.salesloft.com/v2/people.json'.freeze
      AUTH_HEADER = 'Bearer fake-token'.freeze
      TOKEN = 'fake-token'.freeze
      MOCK_RESPONSE = {
        data: [{
          id: 101693889,
          created_at: '2018-03-13T00:39:59.820272-04:00',
          updated_at: '2018-03-13T00:39:59.820272-04:00',
          display_name: 'Orlando Stanton',
          email_address: 'katrina_langosh@kozey.io',
          title: 'Regional Factors Specialist'
        }]
      }.freeze

      def test_get_people
        stub_request(:get, TEST_URL)
          .with(
            headers: { Authorization: AUTH_HEADER },
            query: { page: 1, per_page: 25 }
          )
          .to_return(body: MOCK_RESPONSE.to_json)

        gateway = Gateway.new TOKEN

        response = gateway.get

        first_person = response.first
        assert_equal 'Orlando Stanton', first_person[:name]
        assert_equal 'katrina_langosh@kozey.io', first_person[:email]
        assert_equal 'Regional Factors Specialist', first_person[:title]
      end

      def test_unauthorized
        stub_request(:get, TEST_URL)
          .with(
            headers: { Authorization: AUTH_HEADER },
            query: { page: 1, per_page: 25 }
          )
          .to_return(status: 401)

        gateway = Gateway.new TOKEN

        assert_raises Unauthorized do
          gateway.get
        end
      end

      def test_internal_server_error
        stub_request(:get, TEST_URL)
          .with(
            headers: { Authorization: AUTH_HEADER },
            query: { page: 1, per_page: 25 }
          )
          .to_return(status: 500)

        gateway = Gateway.new TOKEN

        assert_raises InternalServerError do
          gateway.get
        end
      end

      def test_unexpected_error
        stub_request(:get, TEST_URL)
          .with(
            headers: { Authorization: AUTH_HEADER },
            query: { page: 1, per_page: 25 }
          )
          .to_return(status: 404)

        gateway = Gateway.new TOKEN

        assert_raises GatewayError do
          gateway.get
        end
      end

      def test_unexpected_response
        stub_request(:get, TEST_URL)
          .with(
            headers: { Authorization: AUTH_HEADER },
            query: { page: 1, per_page: 25 }
          )
          .to_return(body: 'Im not an array')

        gateway = Gateway.new TOKEN

        assert_raises UnexpectedResponse do
          gateway.get
        end
      end
    end
  end
end
