[![Build Status](https://circleci.com/gh/logicalgroove/legacy_column.svg?style=shield)](https://app.circleci.com/pipelines/github/logicalgroove/legacy_column)
[![License](https://img.shields.io/badge/License-MIT-yellowgreen.svg)](https://img.shields.io/badge/License-MIT-yellowgreen.svg)

# LegacyColumn

A gem that will print a message if a developer is trying to use a column that is from a legacy system but has to stay there.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'legacy_column'
```

And then execute:
```bash
bundle install
```

## Compatibility

This gem supports:
- Ruby 2.7+
- Rails 5.2+, 6.0+, 6.1+, 7.0+, 7.1+, 7.2+, 8.0+

## Usage

Just list the column names:
```ruby
legacy_column :old_email, :old_phone_number
```

A custom message can be added:
```ruby
legacy_column :old_email, :old_phone_number, message: 'Do not touch this!!!'
```

It will output something like this in Rails logs:

```
Use of legacy column detected.
  User => old_email
  Do not touch this!!!
```

## Output

The gem will:
- Log warnings to `Rails.logger` when Rails is available
- Fall back to `puts` for non-Rails environments or when Rails.logger is not available

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
