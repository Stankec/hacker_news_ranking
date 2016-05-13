$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'pry'
require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start
require 'hacker_news_ranking'
