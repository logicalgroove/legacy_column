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

### Basic Usage

Just list the column names:
```ruby
legacy_column :old_email, :old_phone_number
```

A custom message can be added:
```ruby
legacy_column :old_email, :old_phone_number, message: 'Do not touch this!!!'
```

### Read Access Detection

By default, the gem only detects write operations (when columns are modified). To also detect read access, use the `detect_reads` option:

```ruby
legacy_column :old_email, :old_phone_number, detect_reads: true
```

This will warn whenever the legacy columns are accessed:

```ruby
legacy_column :old_status, message: 'This field is deprecated!', detect_reads: true

user.old_status  # Will log a warning about read access
user.old_status = 'active'  # Will log a warning about write access
```

### Combined Usage

You can combine read detection with custom messages:
```ruby
legacy_column :old_price, :old_name, 
              message: 'These fields will be removed in v2.0!', 
              detect_reads: true
```

## Output Examples

### Write Detection (Default)
```
USE of legacy column detected.
  User => old_email
  Do not touch this!!!
```

### Read Detection (When enabled)
```
READ of legacy column detected.
  User => old_email
  Do not touch this!!!
```

## Logging

The gem will:
- Log warnings to `Rails.logger` when Rails is available  
- Fall back to `puts` for non-Rails environments or when Rails.logger is not available

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `message` | `"This column is set as legacy and should not be used anymore."` | Custom warning message |
| `detect_reads` | `false` | Enable read access detection |

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
