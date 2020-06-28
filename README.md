# Validator

Interview task for [Gotoinc](https://gotoinc.co/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'validator'
```

And then execute:
```
bundle install
```

Or install it yourself as:

```
gem install validator
```

## Usage

Clone repo

```
git clone https://github.com/LinchSmyth/validator
cd ./validator
```

Bundle

```
bundle
```

Enter the console

```
bin/console
```

And you're ready!

## Example

```ruby
class User
  include Validator
  
  attr_accessor :first_name, :last_name, :phone, :inviter
  
  # allows to pass several fields at a time
  validate :first_name, :last_name, presence: true
  validate :phone, format: /\A\+\d{3}-\d{3}-\d{3}\z/
  # also supports different validations on single field
  validate :inviter, presence: true, type: User
  
end

user = User.new
user.valid? # => false
user.validate! # => ValidationError: `first_name` should be present

user.first_name = 'Alex'
user.validate! # => ValidationError: `last_name` should be present

user.last_name = 'Blaire'
user.phone = '#123-456'
user.validate! # => ValidationError: `phone` have invalid format

user.phone = '+123-456-789'
user.validate! #=> ValidationError: `inviter` should be present

user.inviter = 'smbd'
user.validate! #=> ValidationError: `inviter` is not instance of User
user.inviter = User.new
user.validate! # => true
user.valid? # => true
```

## Notes

- `presence` validator supports `false` as well, meaning that value should be `nil`.
- despite all validations are inheritable, you're not allowed to overwrite them:
```ruby
class User
  include Validator
  validate :attr, presence: true
  validate :attr, presence: false # will raise error
end
```
- package also performs checks for available validator:
```ruby
class User
  include Validator
  validate :attr, foo: 'value' # will raise error
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
