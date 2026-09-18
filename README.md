# SuperAwesomePrint

[![CI](https://github.com/olegantonyan/super_awesome_print/actions/workflows/ci.yml/badge.svg)](https://github.com/olegantonyan/super_awesome_print/actions/workflows/ci.yml)

Prints values with [awesome_print](https://github.com/awesome-print/awesome_print), framed by colored `***` markers, a timestamp and the caller location, so they're easy to spot in long console output.

![screenshot](https://cloud.githubusercontent.com/assets/2301579/12552398/45e9fa4c-c37a-11e5-8113-a9014d153ebb.png)

```ruby
def index
  @posts = Post.all
  sap @posts
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'super_awesome_print'
```

And then run:

    $ bundle install

Or install it yourself:

    $ gem install super_awesome_print

Requires Ruby 2.7 or newer.

## Configuration

Optionally, customize it in an initializer. In Rails, add the following to `config/initializers/super_awesome_print.rb`:

```ruby
SuperAwesomePrint.configure do |config|
  config.caller_lines = 3 # number of backtrace lines to print, defaults to 1
  config.blank_lines_top = 2 # defaults to 0
  config.blank_lines_bottom = 2 # defaults to 0
  config.root_path = Rails.root.to_s # stripped from caller paths, defaults to Rails.root
  config.log_file_path = '/some/path/to/log/file' # where `sapf` writes
end
```

## Usage

Call `sap` anywhere to print a value. It returns its argument, so you can wrap an expression without changing it:

```ruby
total = sap(items.sum(&:price))
```

To write to a file instead, use `sapf`:

```ruby
sapf 'hello world'
```

By default, `sapf` appends to `sapf.log` in the current directory, or to `log/sapf.log` in Rails. Set `log_file_path` to change it.

To keep `sap` from leaking into production, see the [RuboCop cop](https://github.com/olegantonyan/super_awesome_print_rubocop).

## Development

After checking out the repo, run `bin/setup` to install dependencies, then `bundle exec rake test` to run the tests. Run `bin/console` for an interactive prompt.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, then run `bundle exec rake release`. This creates a git tag for the version, pushes git commits and tags, and pushes the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/olegantonyan/super_awesome_print. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](https://www.contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
