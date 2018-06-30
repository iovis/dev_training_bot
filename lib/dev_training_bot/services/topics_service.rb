class TopicsService
  def initialize(drive_service)
    @drive_service = drive_service
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
    @topics ||= content.string[/Open Topics\s+(\*.*\r\n)+/].scan(/(?<=\* ).*(?=\r)/).sort
  end
end
