describe Fastlane::Actions::TeamsMessageCardAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The teams_message_card plugin is working!")

      Fastlane::Actions::TeamsMessageCardAction.run(nil)
    end
  end
end
