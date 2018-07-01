require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

class SlackService
  def initialize
    @client = Slack::Web::Client.new
    @client.auth_test
  end

  def create_poll(topics)
    @client.chat_command channel: ENV['SLACK_CHANNEL'],
                         command: '/poll',
                         text: "\"Vote for the next dev learning!\" #{topics}"
  end
end
