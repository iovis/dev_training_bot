module DevTrainingBot
  class TopicService
    OPEN_TOPICS_REGEX = /Open Topics\s+(\*.*\r\n)+/
    TOPIC_ITEM_REGEX  = /(?<=\* ).*(?=\r)/

    def initialize(drive_service)
      @drive_service = drive_service
    end

    def to_poll
      return '' if empty?
      "\"#{topics.first(10).join('" "')}\""
    end

    def content
      @content ||= @drive_service.export_file(ENV['FILE_ID'], 'text/plain', download_dest: StringIO.new)
    end

    ##
    # Returns a list of topics from a string in the following format:
    #
    # Open Topics
    # * David: Browser rendering optimization: how to get silky smooth animations
    # * David: The JS Event Loop: what nightmares are made of
    # * David: RxJS: Observing the death of Promises
    # * David: Intro to vim
    # * Mo: Ansible
    # * Julio: CSI:RMD Reading error reports like a $BOSS
    # * Anthony: SAML
    # * Jimmi: Gang of Four Design Patterns in Ruby (possibly in different parts)
    #
    # @return [string]
    def topics
      @topics ||= import.map { |topic| Topic.parse(topic) }
    end

    def empty?
      topics.empty?
    end

    private

    def import
      list = content.string[OPEN_TOPICS_REGEX].scan(TOPIC_ITEM_REGEX)
      return [] if list.all?(&:empty?)
      list.sort
    end
  end
end
