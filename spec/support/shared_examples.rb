shared_examples 'a topic parsing' do |topic, title, author|
  it 'parses the topic' do
    topic_model = described_class.parse(topic)

    expect(topic_model.title).to eq title
    expect(topic_model.author).to eq author
  end
end
