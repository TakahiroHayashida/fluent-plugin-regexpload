 test/version_tmp
# Fluent::Plugin::Regexpload

Random message generate & Loading plugin for fluent.

## Installation

Add this line to your application's Gemfile:

    gem 'fluent-plugin-regexpload'

And then execute:

    $ bundle

Or install it yourself as: 

    $ gem install fluent-plugin-regexpload

## Usage

    <match **>
      repeats 10
      emit_interval 0.1
      tag LOAD
      json_regexp_rand_seed /\d\d\d/
    </match>

## Contributing

1. Fork it ( http://github.com/<my-github-username>/fluent-plugin-regexpload/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
