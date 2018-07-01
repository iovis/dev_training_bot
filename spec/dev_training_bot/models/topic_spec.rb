require 'support/shared_examples'

describe DevTrainingBot::Topic do
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
  end
end
