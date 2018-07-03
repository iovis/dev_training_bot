[![Gem Version](https://badge.fury.io/rb/dev_training_bot.svg)](https://badge.fury.io/rb/dev_training_bot) [![Build Status](https://travis-ci.org/iovis9/dev_training_bot.svg?branch=master)](https://travis-ci.org/iovis9/dev_training_bot)

# DevTrainingBot

List, publish or export the Dev Training topics (made for RubiconMD).

## Installation

Install the gem:

    $ gem install dev_training_bot

Turn on the [Drive API](https://developers.google.com/drive/api/v3/quickstart/ruby#prerequisites) and download your `client_secrets.json` file.

Generate a [token](https://api.slack.com/custom-integrations/legacy-tokens) for your Slack user.
**NOTE:** bots can't execute slash commands like `/poll`

Configure the following environment variables:
```sh
CLIENT_SECRETS_PATH="$HOME/.client_secrets.json"
FILE_ID=<Google Docs file id>
SLACK_API_TOKEN=<your slack user token>
SLACK_CHANNEL="#your_channel"
```

## Usage

```
$ training

Commands:
  training help [COMMAND]  # Describe available commands or one specific command
  training list            # Show the list of available topics
  training open            # Open Dev Training document in your browser
  training publish         # Send a poll to the configured channel
  training save <file>     # Save Dev Training document to disk
```

**NOTE:** The command `save` accepts an optional `--format` parameter (see `training help save`)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/iovis9/dev_training_bot.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
