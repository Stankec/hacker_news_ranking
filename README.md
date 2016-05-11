# Hacker News Ranking

Add a roubust ranking system that deteriates over time to your application.
This system is used by sites the like of Reddit and Hacker News to rank their
posts by 'hottest' or 'trending'.

## About

The Hacker News 'algorithm' scores each entry using the following formula:

```Ruby
rank = (points - 1) / [(time + 2)^gravity]
```

The `points` field defines which value, or combination of values, will generate
the base rank. The difference between now and the time the entry was created is
expressed in the `time` field (in hours). The `gravity` field determines how
much the passage of time plays a role. The higher the gravity, the more an
entries ranking deteriates over time.

Here is a graph rendering the deteriation of an entrie's rank oer time:

![Graph rendering of rank change over time](/docs/deteriation_graph.png)

* Blue (furthest right): `points = 100`, `gravity = 2.3`
* Orange (middle): `points = 100`, `gravity = 1.8`
* Red (furthest left): `points = 100`, `gravity = 1.3`


## Install

To use this gem in your project add the following to your `Gemfile`:

```Ruby
gem 'hacker_news_ranking'
```

If you just want to try the gem out in `irb` or `pry` then run the following
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

The above will use the `favorites_count` attribute to rank each 'Post'. It will
create a `rank` method on each instance of `Post` and add a `trending` scope to
the model.

The following example shows all available configuration options with their
default values:

```Ruby
class Post < ActiveRecord::Base
  include HackerNewsRanking.new(
    points: nil, # this field is required
    timestamp: :created_at,
    gravity: 1.8,
    scope_method: :trending,
    current_rank_method: :rank
  )
end
```

The default configuration can be changed in the following manner:

```Ruby
HackerNewsRanking.configure do
  points :comments_count
  timestamp :commented_at
  gravity 2.3
  scope_method :controversial
  points_method :points
end
```

## ORM usage

Hacker News Ranking currently supports `ActiveRecord` and `Sequel`.

When used in each respective ORM's models it tries to generate SQL queries which
calculate the rank for each entry. If the passed _symbols_ doesn't corespond to
a column in the model's table a `HackerNewsRanking::MissingColumnError` will be
raised.

If a _block_ is passed to ether the `points` or the `timestamp` attribute all
__relations will be evaluated as arrays!__

## Plain old Ruby usage

Any array can be ranked using the `rank` and `rank!` class methods.

```Ruby
HackerNewsRanking.rank(
  array: [1, 2, 3, 4],
  points: &:to_i,
  timestamp: -> { Time.now }
)
```

## Contributing

Contributions are much welcome!

Please feel free to fork this project and to make pull requests.

## License
