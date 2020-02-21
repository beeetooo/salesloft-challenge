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
        page = params[:page]&.to_i || 1
        per_page = params[:per_page]&.to_i || 25

        gateway = Application::People::Gateway.new @api_token
        people = gateway.get page: page, per_page: per_page

        {
          results: people,
          page: page,
          per_page: per_page,
        }.to_json
      rescue Application::People::Unauthorized
        [401, {}, 'Access to API unauthorized. Please contact your system administrator']
      rescue Application::People::GatewayError => error
        puts 'si hubo pedo entonces'
        puts error
        [500]
      end

      get "/favicon.ico" do
      end
    end
  end
end
