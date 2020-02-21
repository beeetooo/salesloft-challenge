$LOAD_PATH << File.join(File.dirname(__FILE__), '..')
$stdout.sync = true
require 'sinatra/base'
require 'json'

require 'application/people/gateway'

module Application
  module Server
    class App < Sinatra::Application
      def initialize(config = {})
        super
        @api_token = config[:api_token]
      end

      get '/people' do
        gateway = Application::People::Gateway.new @api_token
        people = gateway.get

        people.to_json
      rescue Application::People::Unauthorized => error
        [401, {}, 'Access to API unauthorized. Please contact your system administrator']
      rescue Application::People::GatewayError => error
        [500]
      end

      get "/favicon.ico" do
      end
    end
  end
end
