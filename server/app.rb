$LOAD_PATH << File.join(File.dirname(__FILE__), '..')

require 'sinatra/base'

module Application
  module Server
    class App < Sinatra::Application
      def initialize(config)
        super
        @api_token = config[:api_token]
      end

      get '/' do
        'Hello'
      end

      get "/favicon.ico" do
      end
    end
  end
end
