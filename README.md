# Autodiff

*Work In Progress*

Calculating gradient or differential is a very common task when working in Math heavy field like Machine Learning. But deriving gradient by hand is time-consuming and error-prone.

Automatic Differentiation(AD) can calculate gradient of arbitrary function automatically. AD is efficient(for human) and correct(without human error).

## Usage


```
require 'autodiff'
# Calculate differential of a function
# df/dx = 3*(x**2)
Autodiff.gradient(2) { |x| x**3} # 12  

# Calculate gradient of a function
# df/dx = y, df/dy = x
Autodiff.gradient([2,3]) { |x, y| x * y } # [3,2]

# Calculate gradient with triangular function
Autodiff.gradient([2,Math::PI]) { |x, y|x * Math.cos(y) }
# [-1.0, -2.4492935982947064e-16] with floating point error

# Calculate gradient of a function that is not in simple math form
# same as 20x+30y
Autodiff.gradient([1, 1]) {|x,y| 10.times.reduce(0){|acc, n| acc + 2*x + 3*y} } # [20, 30]

```

## Features

current supported operators
- +, -, *, /
- sin, cos, tan, log

Goal is to add all Numeric & Math functions

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'autodiff'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install autodiff


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/johnlinvc/autodiff. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Autodiff project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/johnlinvc/autodiff/blob/master/CODE_OF_CONDUCT.md).
