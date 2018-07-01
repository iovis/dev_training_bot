describe DevTrainingBot::Cli do
  let(:topic_service) { instance_double 'DevTrainingBot::TopicService' }
  let(:slack_service) { instance_double 'DevTrainingBot::SlackService' }

  describe '#open' do
    it 'launches the browser with the document' do
      expect(Launchy).to receive(:open).with(DevTrainingBot::GoogleDriveService::DOC_URL)
      subject.open
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
