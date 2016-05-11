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
  include HackerNewsRanking.new(points: :favorites_count)
end
```

```Ruby
class Post < ActiveRecord::Base
  include HackerNewsRanking.new(
    points: sql { comments_count + favorites_count },
    timestamp: :created_at,
    gravity: 1.8,
    scope_method: :trending,
    current_rank_method: :rank
  )
end
```

```Ruby
HackerNewsRanking.configure do
  timestamp :updated_at
  gravity: 1.8
  scope_method :hottest
  points_method :points
end
```
