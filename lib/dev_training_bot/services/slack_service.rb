require 'chronic'
require 'slack-ruby-client'

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

module DevTrainingBot
  class SlackService
    def initialize
      @client = Slack::Web::Client.new
      @client.auth_test
    end

    def create_poll(topics)
      return no_topics_available if topics.empty?

      next_friday = Chronic.parse('next friday').to_date

      @client.chat_command channel: ENV['SLACK_CHANNEL'],
                           command: '/poll',
                           text: "\"@engineering Vote for the next dev learning! [#{next_friday}]\" #{topics}"
    end

    def no_topics_available
      @client.chat_postMessage channel: ENV['SLACK_CHANNEL'],
                               text: '<!engineering> Please propose your topics for the next Dev Learning!',
                               as_user: true
    end

    def link_doc
      @client.chat_postMessage channel: ENV['SLACK_CHANNEL'],
                               text: GoogleDriveService::DOC_URL,
                               as_user: true
    end
  end
end
