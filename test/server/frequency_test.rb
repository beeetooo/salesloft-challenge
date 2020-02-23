require 'test_helper'
require 'json'
require 'rack/test'

require 'server/app'

module Application
  module Server
    class FrequencyTest < Minitest::Test
      TEST_URL = 'https://api.salesloft.com/v2/people.json'.freeze
      AUTH_HEADER = 'Bearer fake-token'.freeze
      TOKEN = 'fake-token'.freeze
      MOCK_RESPONSE = {
        data: [{
          id: 101693889,
          created_at: '2018-03-13T00:39:59.820272-04:00',
          updated_at: '2018-03-13T00:39:59.820272-04:00',
          display_name: 'Stephen Hawking',
          email_address: 'aaabbb@cc.dd',
          title: 'You know who he is'
        }, {
          id: 101693889,
          created_at: '2018-03-13T00:39:59.820272-04:00',
          updated_at: '2018-03-13T00:39:59.820272-04:00',
          display_name: 'Charles Darwin',
          email_address: 'aaabbb@cc.dd',
          title: 'You know who he is'
        }]
      }.freeze

      include Rack::Test::Methods

      def app
        Server::App.new api_token: TOKEN
      end

      def test_get_frequency
        stub_request(:get, TEST_URL)
          .with(
            headers: { Authorization: AUTH_HEADER },
            query: { page: 1, per_page: 375 }
          )
          .to_return(body: MOCK_RESPONSE.to_json)

        get '/frequency'

        assert last_response.ok?
        assert_equal(
          {
            result: [
              ['b', 6],
              ['a', 6],
              ['d', 4],
              ['c', 4],
              ['.', 2],
              ['@', 2]
            ]
          }.to_json,
          last_response.body
        )
      end
    end
  end
end
