# SuperAwesomePrint

Add colored '*********', time and line number around printed value. It's easier to find such output in a long console output.

![alt tag](https://cloud.githubusercontent.com/assets/2301579/12552398/45e9fa4c-c37a-11e5-8113-a9014d153ebb.png)
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

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install super_awesome_print

You can optionally customize configuration in an initializer.<br/>
In Rails, you can add the following to `config/initializers/super_awesome_print.rb`:

```ruby
SuperAwesomePrint.configure do |config|
  config.caller_lines = 3 # defaults to 1
  config.blank_lines_top = 2 # defaults to 0
  config.blank_lines_bottom = 2 # defaults to 0
  config.root_path = Rails.root.to_s # this path will be removed from caller's files path, defaults to Rails.root.to_s
  config.log_file_path = '/some/path/to/log/file' # override default log file for `sapf`
end
```

## Usage

Just use `sap` global function to print any variable.

You can also print to a file

```ruby
sapf 'hello world'
```

By default it will print everything to `sapf.log` file in current directory or to `log/sapf.log` if you're on Rails. See `log_file_path` config option to override this.

Also, take a look at [cop for RuboCop](https://github.com/olegantonyan/super_awesome_print_rubocop) to make `sap` didn't leak into production.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/olegantonyan/super_awesome_print. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://www.contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
