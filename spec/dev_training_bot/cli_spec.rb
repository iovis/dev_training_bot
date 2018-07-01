describe DevTrainingBot::Cli do
  let(:drive_service) { instance_double 'DevTrainingBot::GoogleDriveService' }
  let(:topic_service) { instance_double 'DevTrainingBot::TopicService' }
  let(:slack_service) { instance_double 'DevTrainingBot::SlackService' }

  describe '#open' do
    it 'launches the browser with the document' do
      expect(Launchy).to receive(:open).with(DevTrainingBot::GoogleDriveService::DOC_URL)
      subject.open
    end
  end

  describe '#save' do
    before do
      allow(DevTrainingBot::GoogleDriveService).to receive(:new).and_return(drive_service)
      allow(subject).to receive(:say)
    end

    it 'saves the document' do
      expect(drive_service).to receive(:export_file).with(ENV['FILE_ID'], 'text/plain', download_dest: 'dev_training.txt')
      subject.save 'dev_training.txt'
    end
  end

  describe '#publish' do
    before do
      allow(DevTrainingBot::TopicService).to receive(:new).and_return(topic_service)
      allow(DevTrainingBot::SlackService).to receive(:new).and_return(slack_service)
      allow(subject).to receive(:say)
    end

    it 'sends the poll to slack' do
      poll_topics = '"poll 1" "poll 2"'

      expect(topic_service).to receive(:to_poll).and_return(poll_topics)
      expect(slack_service).to receive(:create_poll).with(poll_topics)
      expect(slack_service).to receive(:link_doc).with(no_args)

      subject.publish
    end
  end
end
