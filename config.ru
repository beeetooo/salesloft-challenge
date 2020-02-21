require 'bundler/setup'
require 'rake/testtask'

require './server/app'
run Application::Server::App.new api_token: ENV['API_TOKEN']
