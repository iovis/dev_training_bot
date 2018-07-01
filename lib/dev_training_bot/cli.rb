require 'thor'

module DevTrainingBot
  class Cli < Thor
    def self.exit_on_failure?
      true
    end

    desc 'publish', "Send a poll to the #{ENV['SLACK_CHANNEL']} channel"
    def publish
      slack_service.create_poll(topic_service.to_poll)
      say 'Successfully published the poll!', :green
    end

    private

    def topic_service
      @topic_service ||= TopicService.new(GoogleDriveService.new)
    end

    def slack_service
      @slack_service ||= SlackService.new
    end
  end
end
