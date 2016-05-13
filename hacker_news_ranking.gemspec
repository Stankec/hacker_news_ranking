# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hacker_news_ranking/version'

Gem::Specification.new do |spec|
  spec.name = 'hacker_news_ranking'
  spec.version = HackerNewsRanking::VERSION
  spec.authors = ['Stanko Krtalic Rusendic']
  spec.email = ['stanko.krtalic@gmail.com']

  spec.summary = 'A rouboust ranking system'
  spec.description = %(
    Add a robust ranking system that deteriorates over time to your application.
    This system is used by sites the like of Reddit and Hacker News to rank
    their posts by 'hottest' or 'trending'.
  )
  spec.homepage = 'https://github.com/Stankec/hacker_news_ranking'

  spec.files =
    `git ls-files -z`
    .split("\x0")
    .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
