$LOAD_PATH << File.join(File.dirname(__FILE__), '..')

require 'bundler/setup'
require 'minitest/autorun'
require 'webmock/minitest'
