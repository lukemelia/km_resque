# KmResque

An interface for interacting with the KISSmetrics API via Resque. Keeps all direct interactions with the KISSMetrics API out of your requests.

[![Build Status](https://secure.travis-ci.org/lukemelia/km_resque.png)](http://travis-ci.org/lukemelia/km_resque)

## Installation

Add this line to your application's Gemfile:

    gem 'km_resque'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install km_resque

Configure your API key:

    KmResque.configure do |config|
      config.key = '<YOUR-KISSMETRICS-API-KEY>'
    end

## Usage

    KmResque.alias(anonymous_id, user.id)
    KmResque.record(user.id, 'signed_up', { :source => 'contest' })
    KmResque.set(user.id, { :gender => 'F' })

## Running specs

    $ bundle exec rspec spec/

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`); don't forget the specs!
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Written by Luke Melia. Thanks to Yapp for open sourcing KMResque. Inspiration from delayed_kiss and km-delay.

## License

km_resque is available under the terms of the MIT License http://www.opensource.org/licenses/mit-license.php
