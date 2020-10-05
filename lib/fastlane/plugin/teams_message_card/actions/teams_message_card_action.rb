require 'fastlane/action'
require_relative '../helper/teams_message_card_helper'

module Fastlane
  module Actions
    class TeamsMessageCardAction < Action
      def self.run(params)
        require 'net/http'
        require 'uri'

        payload = {
          "@type" => "MessageCard", 
          "@context" => "http://schema.org/extensions",
          "themeColor" => params[:theme_color],
          "title" => params[:title],
          "summary" => params[:summary],
          "sections" => 
          [
            {
              "activityTitle" => params[:activity_title],
              "activitySubtitle" => params[:activity_subtitle],
              "activityImage"  => params[:activity_image],
              "text" => params[:text],
              "facts" => params[:facts],
              "potentialAction" => params[:potential_action]
            }
          ]
        }

        json_headers = { 'Content-Type' => 'application/json' }
        uri = URI.parse(params[:teams_url])
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        response = http.post(uri.path, payload.to_json, json_headers)
        check_response_code(response)
      end

       def self.check_response_code(response)
        if response.code.to_i == 200 && response.body.to_i == 1
          true
        else
          UI.user_error!("An error occurred: #{response.body}")
        end
      end

      def self.description
        "Send a message card to your Microsoft teams channel"
      end

      def self.authors
        ["Dorian Cheignon"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Send a message card to your Microsoft teams channel"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :title,
                                       env_name: "TEAMS_MESSAGE_CARD_TITLE",
                                       description: "The title that should be displayed on Teams"),
          FastlaneCore::ConfigItem.new(key: :summary,
                                       env_name: "TEAMS_MESSAGE_CARD_SUMMARY",
                                       description: "The summary that should be displayed on Teams"),
          FastlaneCore::ConfigItem.new(key: :activity_title,
                                       env_name: "TEAMS_MESSAGE_CARD_ACTIVITY_TITLE",
                                       description: "Use activityTitle to summarize the action. Be clear and concise"),
          FastlaneCore::ConfigItem.new(key: :activity_subtitle,
                                       env_name: "TEAMS_MESSAGE_CARD_ACTIVITY_SUBTITLE",
                                       description: "Use activity subtitle to display, for example, the date and time of the action, or the person's identifier"),
          FastlaneCore::ConfigItem.new(key: :activity_image,
                                       env_name: "TEAMS_MESSAGE_CARD_ACTIVITY_IMAGE",
                                       sensitive: true,
                                       description: "Use activityImage to display the image of that person",
                                       verify_block: proc do |value|
                                         UI.user_error!("Invalid URL, must start with https://") unless value.start_with? "https://"
                                       end),
          FastlaneCore::ConfigItem.new(key: :text,
                                       env_name: "TEAMS_MESSAGE_CARD_TEXT",
                                       description: "The message that should be displayed on Teams. This supports the standard Teams markup language"),
          FastlaneCore::ConfigItem.new(key: :facts,
                                       type: Array,
                                       env_name: "TEAMS_MESSAGE_CARD_FACTS",
                                       description: "Optional facts"),
          FastlaneCore::ConfigItem.new(key: :potential_action,
                                       type: Array,
                                       env_name: "TEAMS_MESSAGE_CARD_POTENTIAL_ACTION",
                                       description: "Optional facts"),
          FastlaneCore::ConfigItem.new(key: :teams_url,
                                       env_name: "TEAMS_MESSAGE_CARD_TEAMS_URL",
                                       sensitive: true,
                                       description: "Create an Incoming WebHook for your Teams channel",
                                       verify_block: proc do |value|
                                         UI.user_error!("Invalid URL, must start with https://") unless value.start_with? "https://"
                                       end),
          FastlaneCore::ConfigItem.new(key: :theme_color,
                                       env_name: "TEAMS_MESSAGE_CARD_THEME_COLOR",
                                       description: "Theme color of the message card",
                                       default_value: "8e8e93")
        ]
      end


      def self.example_code
        [
          'teams_message_card(
            title: "Fastlane says hello",
            summary: "Test summary",
            text: "Test text",
            activity_title: "Someone",
            activity_subtitle: "9/13/2016, 3:34pm",
            activity_image: "https://connectorsdemo.azurewebsites.net/images/MSC12_Oscar_002.jpg",
            facts:[
              {
                "name"=>"Platform",
                "value"=>"iOS"
              },
              {
                "name"=>"Lane",
                "value"=>"iOS internal"
              }
            ],
            potential_action:[
              {
                "@type": "OpenUri",
                "name": "View in Trello",
                "targets": [
                  { 
                    "os": "default", 
                    "uri": "https://..."
                  }
                ]
              }
            ],
            teams_url: "https://outlook.office.com/webhook/..."
          )'
        ]
      end

      def self.category
        :notifications
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
