# Slack Notification GitHub Action

This GitHub Action allows you to send Slack notifications using predefined templates stored in the action repository. It leverages the `slackapi/slack-github-action@v2` to send messages to Slack channels, with the added flexibility of selecting a template by name.

## Features

- **Centralized Templates**: Templates are stored in the action repository, so users don't need to include `.json` files in their repositories.
- **Dynamic Template Selection**: Users can select a template by name using the `template_name` input.

---

## Inputs

| Name               | Required | Default                  | Description                                                                 |
|--------------------|----------|--------------------------|-----------------------------------------------------------------------------|
| `status`           | Yes      |                          | The job status (e.g., `success` or `failure`).                             |
| `method`           | Yes      |                          | The Slack API method to call (e.g., `chat.postMessage`).                   |
| `token`            | Yes      |                          | The Slack bot token for authentication.                                    |
| `run_id`           | No       |  github.run_id           | The GitHub Actions run number.                                             |
| `channel_id`       | Yes      |                          | The Slack channel ID where the message will be sent.                       |
| `template_name`    | Yes      | `default-payload.json`   | The name of the template to use (e.g., `default-payload.json`).            |
| `payload-templated`| No       | `true`                   | Whether to replace templated variables in the payload.                     |
| `api`              | No       |                          | A custom API URL to send Slack API method requests to.                     |
| `proxy`            | No       |                          | An optional proxied route for HTTPS connections.                           |
| `retries`          | No       | `5`                      | The number of retries for failed requests.                                 |
| `webhook`          | No       |                          | A location for posting request payloads.                                   |
| `webhook-type`     | No       |                          | Option to use either an incoming webhook or webhook trigger.               |
| `errors`           | No       | `false`                  | Whether the step exits with an error on errors or continues.               |

---

## Outputs

| Name         | Description                                                                 |
|--------------|-----------------------------------------------------------------------------|
| `ok`         | Whether the request completed without returning errors.                    |
| `response`   | A JSON stringified version of the Slack API response.                      |
| `time`       | The Unix epoch time that the step completed.                               |
| `channel_id` | The channel ID returned with some of the Slack API methods.                |
| `thread_ts`  | The timestamp of a parent Slack message with threaded replies.             |
| `ts`         | The timestamp of a Slack message or event in the response.                 |

## Reference about how action works

[slackapi/slack-github-action](https://github.com/slackapi/slack-github-action)

---

## Usage

### Example Workflow

```yaml
name: Slack Notification Test

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  test-default-payload:
    name: Test Default Payload
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Send Slack Notification 
        uses: hemupadhyay26/slack-github-action-template@v1.0
        with:
          status: success
          method: chat.postMessage
          token: ${{ secrets.SLACK_BOT_TOKEN }}
          channel_id: ${{ vars.SLACK_CHANNEL_ID }}

  test-plain-text-payload:
    name: Test Plain Text Payload
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Send Slack Notification with Plain Text Template
        uses: hemupadhyay26/slack-github-action-template@v1.0
        with:
          status: failure
          method: chat.postMessage
          token: ${{ secrets.SLACK_BOT_TOKEN }}
          run_id: ${{ github.run_id }}
          channel_id: ${{ vars.SLACK_CHANNEL_ID }}
          template_name: plain-text-payload.json
