module DevTrainingBot
  class Topic
    REGEX = /(?<author>.*?):\s*(?<title>.+)/

    attr_accessor :title, :author

    def self.parse(topic)
      topic.match(REGEX) { |matches| new(matches[:title], matches[:author]) }
    end

    def initialize(title, author)
      @title = title
      @author = author
    end
  end
end
