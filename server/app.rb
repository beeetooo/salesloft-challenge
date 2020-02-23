$LOAD_PATH << File.join(File.dirname(__FILE__), '..')
$stdout.sync = true

require 'sinatra/base'
require 'sinatra/cross_origin'
require 'json'

require 'server/gateways/people'
require 'server/use-cases/get_emails_characters_frequency'

module Application
  module Server
    class App < Sinatra::Application
      set :bind, '0.0.0.0'

      configure do
        enable :cross_origin
      end

      before do
        response.headers['Access-Control-Allow-Origin'] = '*'
      end

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
          per_page: per_page
        }.to_json
      rescue Application::People::Unauthorized
        [401, {}, 'Access to API unauthorized. Please contact your system administrator']
      rescue Application::People::GatewayError
        [500]
      end

      get '/frequency' do
        gateway = Application::People::Gateway.new @api_token
        use_case = Application::UseCases::GetEmailsCharactersFrequency.new gateway

        { result: use_case.execute }.to_json
      end

      get '/favicon.ico' do
      end

      options '*' do
        response.headers['Allow'] = 'GET, PUT, POST, DELETE, OPTIONS'
        response.headers['Access-Control-Allow-Headers'] = \
          'Authorization, Content-Type, Accept, X-User-Email, X-Auth-Token'
        response.headers['Access-Control-Allow-Origin'] = '*'
        200
      end
    end
  end
end
