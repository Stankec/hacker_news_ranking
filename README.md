[![Build Status](https://travis-ci.org/Stankec/hacker_news_ranking.svg?branch=master)](https://travis-ci.org/Stankec/hacker_news_ranking)
[![Code Climate](https://codeclimate.com/github/Stankec/hacker_news_ranking/badges/gpa.svg)](https://codeclimate.com/github/Stankec/hacker_news_ranking)
[![Test Coverage](https://codeclimate.com/github/Stankec/hacker_news_ranking/badges/coverage.svg)](https://codeclimate.com/github/Stankec/hacker_news_ranking/coverage)
[![Issue Count](https://codeclimate.com/github/Stankec/hacker_news_ranking/badges/issue_count.svg)](https://codeclimate.com/github/Stankec/hacker_news_ranking)

# Hacker News Ranking

Add a robust ranking system that deteriorates over time to your application.
This system is used by sites the like of Reddit and Hacker News to rank their
posts by 'hottest' or 'trending'.

## About

The Hacker News 'algorithm' scores each entry using the following formula:

```Ruby
rank = (points + points_offset) / [(time + time_offset)^gravity]

# Default values
# points_offset = -1
# time_offset = 2
# gravity = 1.8
```

The `points` field defines which value, or a combination of values, will
generate the base rank. The difference between now and the time the entry was
created is expressed in the `time` field (in hours). The `gravity` field
determines how much the passage of time plays a role. The higher the gravity,
the more an entries ranking deteriorates over time.

Here is a graph rendering the deterioration of an entrie's rank over time:

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
    points_offset: -1,
    timestamp: :created_at,
    timestamp_offset: 2,
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
  points_offset: 0,
  timestamp :commented_at
  timestamp_offset 5,
  gravity 2.3
  scope_method :controversial
  current_rank_method :points
end
```

## ORM usage

Hacker News Ranking currently supports `ActiveRecord` and `Sequel`.

When used in each respective ORM's models it tries to generate SQL queries which
calculate the rank for each entry. If the passed _symbols_ doesn't corespond to
a column in the model's table a `HackerNewsRanking::MissingColumnError` will be
raised.

If a _block_ is passed to either the `points` or the `timestamp` attribute all
__relations will be evaluated as arrays!__

More advanced SQL commands can be achieved by passing a _string_ to either
attribute.

## Plain old Ruby usage

Any array can be ranked using the `rank` and `rank!` class methods.

```Ruby
HackerNewsRanking.rank(
  array: [1, 2, 3, 4],
  points: :to_i,
  timestamp: proc { Time.now.to_i }
)
```

Arrays can also _include_ with the `rank` and `rank!` methods by doing the
following:

```Ruby
Array.include(HackerNewsRanking::ArrayMethods)

array = [1, 2, 3, 4]
array.rank!(
  points: :to_i,
  timestamp: -> (number) { Time.now.hours / number },
  gravity: 0.7
)
```

The `rank` method will return a new instance of an `Array`. While `rank!` will
modify the passed object.

## Contributing

Please feel free to fork this project and to make pull requests. Support for
more ORMs, features and bug fixes are always welcome.
Opening issues is also cosidered contributing!

## License

This project is released under the MIT license. The full text of the license
can be found in the [ LICENSE ](/LICENSE) file.
Note that this software is provided 'as is', _without_ any warranty of any kind.
