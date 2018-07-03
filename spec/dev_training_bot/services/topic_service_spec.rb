describe DevTrainingBot::TopicService do
  let(:file)       { StringIO.new(File.read('spec/support/dev_training.txt')) }
  let(:empty_file) { StringIO.new(File.read('spec/support/dev_training_empty.txt')) }
  let(:full_file)  { StringIO.new(File.read('spec/support/dev_training_full.txt')) }
  let(:service)    { instance_double 'GoogleDriveService' }
  let(:topics) do
    convert_to_topics [
      'Anthony: SAML',
      'David: Browser rendering optimization: how to get silky smooth animations',
      'David: Intro to vim',
      'David: RxJS: Observing the death of Promises',
      'David: The JS Event Loop: what nightmares are made of',
      'Jimmi: Gang of Four Design Patterns in Ruby (possibly in different parts)',
      'Julio: CSI:RMD Reading error reports like a $BOSS',
      'Mo: Ansible'
    ]
  end

  subject { described_class.new(service) }

  describe '#topics' do
    it 'should return the list of topics in order' do
      expect(service).to receive(:export_file).and_return(file)
      expect(subject.topics).to eq topics
    end
  end

  describe '#empty?' do
    context 'when there are topics available' do
      it 'returns false' do
        allow(service).to receive(:export_file).and_return(file)
        is_expected.not_to be_empty
      end
    end

    context 'when there are no topics available' do
      it 'returns true' do
        allow(service).to receive(:export_file).and_return(empty_file)
        is_expected.to be_empty
      end
    end
  end

  describe '#to_poll' do
    context 'when there are topics available' do
      it 'returns the topics in the poll format' do
        allow(subject).to receive(:topics).and_return(
          convert_to_topics([
            'first item',
            'second item'
          ])
        )

        expect(subject.to_poll).to eq '"Unknown: first item" "Unknown: second item"'
      end
    end

    context 'when there are no topics available' do
      it 'returns an empty string' do
        allow(service).to receive(:export_file).and_return(empty_file)
        expect(subject.to_poll).to eq ''
      end
    end

    context 'when there are more than 10 topics' do
      it 'returns 10' do
        allow(service).to receive(:export_file).and_return(full_file)
        topic_list = subject.to_poll.split(/(?<=") (?=")/)
        expect(topic_list.size).to eq 10
      end
    end
  end

  def convert_to_topics(list)
    list.map { |topic| DevTrainingBot::Topic.parse(topic) }
  end
end
