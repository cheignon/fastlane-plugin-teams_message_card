# teams_message_card plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-teams_message_card)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-teams_message_card`, add it to your project by running:

```bash
fastlane add_plugin teams_message_card
```

## About teams_message_card

Send a message card to your Microsoft teams channel

**Note to author:** Add a more detailed description about this plugin here. If your plugin contains multiple actions, make sure to mention them here.

## Example
```
teams_message_card(
            title: "test title",
            summary: "test summary",
            text: "test text",
            activity_title: "test activity_title",
            activity_subtitle: Time.now.strftime("%d/%m/%Y %H:%M"),
            activity_image: "test activity_image (must be start with https)",
            theme_color: 8e8e93,
            facts:[
              {
                "name"=>"Platform",
                "value"=> ios
              }
            ],
            potential_action:[
              {
                "@type": "OpenUri",
                "name": "View in TEST",
                "targets": [
                  { 
                    "os": "default", 
                    "uri": "https://github.com/cheignon/fastlane-plugin-microsft_teams_message_card/edit/main/README.md"
                  }
                ]
              },
              ...
            ],
            teams_url: "https://outlook.office.com/webhook/..."
          )
```

for potential_action for the type don't forget the '@'  like that "@type"

## Potential action Availbale


| @type | description |
| ------ | ------ |
| OpenUri | Open a URI in another browser or application. |
| HttpPOST | Calls to an external web service. |
| ActionCard | Presents the additional user interface which contains one or more entries, as well as the associated actions which can be of type OpenUri or HttpPOST. |
| InvokeAddInCommand | Opens the task pane of an Outlook add-in. If the add-in is not installed, the user is prompted to install it with one click. |

### OpenUri example

```
potential_action:[
              {
                "@type": "OpenUri",
                "name": "View in TEST",
                "targets": [
                  { 
                    "os": "default", 
                    "uri": "https://github.com/cheignon/fastlane-plugin-microsft_teams_message_card/edit/main/README.md"
                  }
                ]
              }
            ]
```
### HttpPOST example
HttpPOST can't be use alone, you need to use ActionCard type before,like that :
```
potential_action:[

{
  "@type": "ActionCard",
  "name": "Comment",
  "inputs": [
    {
      "@type": "TextInput",
      "id": "comment",
      "isMultiline": true,
      "title": "Input's title property"
    }
  ],
  "actions": [
    {
      "@type": "HttpPOST",
      "name": "Action's name prop.",
      "target": "https://yammer.com/comment?postId=123",
      "body": "comment={{comment.value}}"
    }
  ]
}

```

### More example 

the documatation is on [_Legacy actionable message card reference_](https://docs.microsoft.com/en-us/outlook/actionable-messages/message-card-reference)

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
