require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class TeamsMessageCardHelper
      # class methods that you define here become available in your action
      # as `Helper::TeamsMessageCardHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the teams_message_card plugin helper!")
      end
    end
  end
end
