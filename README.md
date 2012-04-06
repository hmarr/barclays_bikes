# barclays_bikes - A Ruby Library for Retreiving Barclays Bike Availability

This may be used as a library or as a command line tool.

### Command Line Usage

Run the `bbikes` command in a shell, optionally providing a query to filter
the station that are displayed.

```console
$ bbikes hatton wall

Hatton Wall, Holborn:
  14 bikes available
  11 spaces available

```

### Using from Ruby

Simply require `barclays_bikes`, then use `BarclaysBikes.load_bike_data` to
fetch the availability information.

```ruby
require 'barclays_bikes'

bike_data = BarclaysBikes.load_bike_data
bike_data['Hatton Wall, Holborn']
# => {:bikes=>13, :spaces=>12}
```

