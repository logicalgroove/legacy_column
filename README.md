# LegacyColumn

A gem that will print a message if a developer is trying to use a column that is from a legacy system but has to stay there.

## Installation


```ruby
gem 'legacy_column'
```

## Usage

Just list the column names:
```ruby
legacy_column :old_email, :old_phone_number
```

A custom message can be added:
```ruby
legacy_column :old_email, :old_phone_number, message: 'Do not touch this!!!'
```

It will output something like this in rails logs:

```
Use of legacy column detected.
  User => old_email
  Do not touch this!!!
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
