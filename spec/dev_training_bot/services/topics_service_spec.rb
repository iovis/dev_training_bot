describe TopicsService do
  let(:file)    { StringIO.new(File.read('spec/support/dev_training.txt')) }
  let(:service) { instance_double 'GoogleDriveService' }
  let(:topics)  {[
    'Anthony: SAML',
    'David: Browser rendering optimization: how to get silky smooth animations',
    'David: Intro to vim',
    'David: RxJS: Observing the death of Promises',
    'David: The JS Event Loop: what nightmares are made of',
    'Jimmi: Gang of Four Design Patterns in Ruby (possibly in different parts)',
    'Julio: CSI:RMD Reading error reports like a $BOSS',
    'Mo: Ansible'
  ]}

  subject { described_class.new(service) }

  describe '#topics' do
    it 'should return the list of topics in order' do
      expect(service).to receive(:export_file).and_return(file)
      expect(subject.topics).to eq topics
    end
  end

  describe '#to_s' do
    it 'returns the topics in the poll format' do
      allow(subject).to receive(:topics).and_return(['first item', 'second item'])
      expect(subject.to_s).to eq '"first item" "second item"'
    end
  end
end
