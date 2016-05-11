# Hacker News Ranking

## About

Easily add a roubust ranking algorithm to your application.

## Install

To use this gem in your project add the following to your `Gemfile`:

```Ruby
gem 'hacker_news_ranking'
```

If you just want to try the gem out in `irb` or `pry` then run the followung
command from your shell of choice:

```BASH
gem install hacker_news_ranking
```

## Usage

A minimal configuration would look like this:

```Ruby
class Post < ActiveRecord::Base
  include HackerNewsRanking.new(:favorites_count)
end
```

```Ruby
class Post < ActiveRecord::Base
  include HackerNewsRanking.new(
    -> { comments_count + favorites_count },
    timestamp: :created_at,
    scope_method: :trending,
    points_method: :rank
  )
end
```

```Ruby
HackerNewsRanking.configure do
  timestamp :updated_at
  scope_method :hottest
  points_method :points
end
```
