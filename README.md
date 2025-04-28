# Candela

Candela provides Ruby bindings for the [Candle](https://github.com/huggingface/candle) machine learning framework using Rust.

## Requirements

- Ruby >= 3.0.0
- Rust and Cargo installed

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'candela'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install candela
```

## Usage

Candela provides access to Candle's Tensor object:

```ruby
require 'candela'

# Create a 2x2 tensor
tensor = Candela::Tensor.new([1.0, 2.0, 3.0, 4.0], [2, 2])

# Get the shape of the tensor
puts tensor.shape  # [2, 2]

# Convert the tensor to a Ruby array
puts tensor.to_vec  # [1.0, 2.0, 3.0, 4.0]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/cpetersen/candela. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/cpetersen/candela/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Candela project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/cpetersen/candela/blob/main/CODE_OF_CONDUCT.md).
