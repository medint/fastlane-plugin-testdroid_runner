# testdroid_runner plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-testdroid_runner)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-testdroid_runner`, add it to your project by running:

```bash
fastlane add_plugin testdroid_runner
```

## About testdroid_runner

Allows to run BitBar tests on fastlane. It has two lanes, testdroid_runner (which runs the tests) and upload_testdroid (uploads a binary to testdroid to use as a live test).

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. The Fastfile includes 4 lanes ready to plugin to your project with a few variables.
Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

## Run tests for this plugin

If you want to run the tests, you need the following variables defined in your environment:

- TESTDROID_RUNNER_API_KEY: The API Key from Bitbar
- TESTDROID_RUNNER_APPLICATION_FILE: The Application to Test
- TESTDROID_RUNNER_TEST_FILE: An Espresso/XCUITest runner binary
- TESTDROID_RUNNER_PROJECT: A BitBar Project
- TESTDROID_RUNNER_DEVICE_GROUP: A BitBar Device Group
- TESTDROID_RUNNER_REPORT_DIR: The directory where all the files produced in BitBar will be stored

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
