$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'codeclimate-test-reporter'
require 'simplecov'

SimpleCov.start
CodeClimate::TestReporter.start
require 'hacker_news_ranking'
