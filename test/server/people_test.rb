require 'test_helper'
require 'json'
require 'rack/test'

require 'server/app'

module Application
  module Server
    class PeopleTest < Minitest::Test
      TEST_URL = 'https://api.salesloft.com/v2/people.json'
      AUTH_HEADER = 'Bearer fake-token'
      TOKEN = 'fake-token'
      MOCK_RESPONSE = {
        data: [{
          id: 101693889,
          created_at: '2018-03-13T00:39:59.820272-04:00',
          updated_at: '2018-03-13T00:39:59.820272-04:00',
          display_name: 'Orlando Stanton',
          email_address: 'katrina_langosh@kozey.io',
          title: 'Regional Factors Specialist'
        }]
      }

      include Rack::Test::Methods

      def app
        Server::App.new api_token: TOKEN
      end

      def test_get_people
        stub_request(:get, TEST_URL)
          .with(
            headers: { Authorization: AUTH_HEADER },
            query: { page: 1, per_page: 1 }
          )
            .to_return(body: MOCK_RESPONSE.to_json)

        get '/people', params={ page: 1, per_page: 1 }

        assert last_response.ok?
        assert_equal(
          {
            results: [{
              id: 101693889,
              name: 'Orlando Stanton',
              email: 'katrina_langosh@kozey.io',
              title: 'Regional Factors Specialist'
            }],
            page: 1,
            per_page: 1
          }.to_json,
          last_response.body
        )
      end

      def test_get_people_unauthorized
        stub_request(:get, TEST_URL)
          .with(
            headers: { Authorization: AUTH_HEADER },
            query: { page: 1, per_page: 25 }
          )
          .to_return(status: 401)

        get '/people'

        assert_equal 401, last_response.status
        assert_equal(
          'Access to API unauthorized. Please contact your system administrator',
          last_response.body
        )
      end

      def test_get_people_fatal_error
        stub_request(:get, TEST_URL)
          .with(
            headers: { Authorization: AUTH_HEADER },
            query: { page: 1, per_page: 25 }
          )
          .to_return(status: 500)

        get '/people'

        assert_equal 500, last_response.status
      end
    end
  end
end
