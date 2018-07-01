require 'support/shared_examples'

describe DevTrainingBot::Topic do
  let(:title)  { 'The JS Event Loop: what nightmares are made of' }
  let(:author) { 'David' }
  subject      { described_class.new(title, author) }

  describe '.parse' do
    it_behaves_like 'a topic parsing',
                    'David: How to create a Gem',
                    'How to create a Gem',
                    'David'

    it_behaves_like 'a topic parsing',
                    'David: The JS Event Loop: what nightmares are made of',
                    'The JS Event Loop: what nightmares are made of',
                    'David'

    it_behaves_like 'a topic parsing',
                    'Julio: CSI:RMD Reading error reports like a $BOSS',
                    'CSI:RMD Reading error reports like a $BOSS',
                    'Julio'

    it_behaves_like 'a topic parsing',
                    'Gang of Four Design Patterns in Ruby (possibly in different parts)',
                    'Gang of Four Design Patterns in Ruby (possibly in different parts)',
                    'Unknown'
  end

  describe '#to_s' do
    it 'returns the formatted topic' do
      expect(subject.to_s).to eq "#{author}: #{title}"
    end
  end
end
