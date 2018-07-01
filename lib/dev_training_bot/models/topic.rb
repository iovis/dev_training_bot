module DevTrainingBot
  class Topic
    REGEX = /(?<author>.*?(?=:))?:?\s*(?<title>.+)/

    attr_accessor :title, :author

    def self.parse(topic)
      topic.match(REGEX) { |matches| new(matches[:title], matches[:author]) }
    end

    def initialize(title, author = 'Unknown')
      @title = title
      @author = author || 'Unknown'
    end

    def to_s
      "#{author}: #{title}"
    end
  end
end
