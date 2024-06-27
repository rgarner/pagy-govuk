# Pagy::GovukExtra

Provides a `pagy_govuk_nav` method that is a drop-in replacement for `pagy_nav`, using the same Pagy "extras" pattern
that already serves Bootstrap, Bulma et al

## Installation

`gem install pagy-govuk`

## Usage

```ruby
  # in your setup, e.g. config/initializers/pagy.rb for a Rails app
  require 'pagy/extras/govuk'
  
  # in your controller, assign a pagy instance as normal
  def index
    @pagy, @posts = pagy(BlogPost.all, items: 10)
  end

  # in your view
  <%= pagy_govuk_nav(@pagy).html_safe %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rgarner/pagy-govuk. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/rgarner/pagy-govuk/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pagy::Govuk project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/rgarner/pagy-govuk/blob/main/CODE_OF_CONDUCT.md).
