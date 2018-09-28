require 'launchy'
require 'thor'

module DevTrainingBot
  class Cli < Thor
    def self.exit_on_failure?
      true
    end

    map %w[--version -v] => :version

    desc 'version', 'Show version'
    def version
      say "v#{VERSION}"
    end

    desc 'open', 'Open Dev Training document in your browser'
    def open
      Launchy.open GoogleDriveService::DOC_URL
    end

    desc 'save <file>', 'Save Dev Training document to disk'
    method_option :format,
                  aliases: '-f',
                  desc: 'Specify the format of the document',
                  default: 'text',
                  enum: GoogleDriveService.formats
    def save(file)
      mime = GoogleDriveService.mime(options[:format])
      drive_service.export_file(ENV['FILE_ID'], mime, download_dest: file)
      say 'Successfully saved the document!', :green
    end

    desc 'publish', "Send a poll to the #{ENV['SLACK_CHANNEL']} channel"
    method_option :exclude,
                  aliases: '-e',
                  type: :array,
                  default: [],
                  desc: 'Exclude authors from the final list'
    def publish
      topics = topic_service.to_poll(exclude: options[:exclude])
      slack_service.create_poll(topics)
      slack_service.link_doc
      say 'Successfully published the poll!', :green
    end

    desc 'list', 'Show the list of available topics'
    def list
      topics_table = topic_service.topics.map do |topic|
        ['', set_color(topic.author, :blue), topic.title]
      end

      print_table topics_table
    end

    private

    def drive_service
      @drive_service ||= GoogleDriveService.new
    end

    def topic_service
      @topic_service ||= TopicService.new(drive_service)
    end

    def slack_service
      @slack_service ||= SlackService.new
    end
  end
end
