require 'fastlane/action'
require_relative '../helper/testdroid_runner_helper'

module Fastlane
  module Actions
    class TestdroidRunnerAction < Action
      def self.run(params)
        $stdout.sync = true
        Helper::RunTest.run(params)
      end

      def self.description
        "BitBar Test Runner"
      end

      def self.authors
        ["josepmc"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "A quick test runner for BitBar that allows either Espresso or XCUITests to be ran through fastlane"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :api_key,
                                  env_name: "TESTDROID_RUNNER_API_KEY",
                                  description: "The API key used to connect to BitBar",
                                  optional: false,
                                  type: String),
          FastlaneCore::ConfigItem.new(key: :application_file,
                                  env_name: "TESTDROID_RUNNER_APPLICATION_FILE",
                                  description: "Either an IPA or APK containing the core application",
                                  optional: false,
                                  type: String),
          FastlaneCore::ConfigItem.new(key: :test_file,
                                  env_name: "TESTDROID_RUNNER_TEST_FILE",
                                  description: "Either an IPA or APK containing the test code",
                                  optional: true,
                                  type: String),
          FastlaneCore::ConfigItem.new(key: :project,
                                  env_name: "TESTDROID_RUNNER_PROJECT",
                                  description: "A BitBar project where to store the test run",
                                  optional: true,
                                  type: String),
          FastlaneCore::ConfigItem.new(key: :device_group,
                                  env_name: "TESTDROID_RUNNER_DEVICE_GROUP",
                                  description: "The BitBar device group to use as target devices",
                                  optional: true,
                                  type: String),
          FastlaneCore::ConfigItem.new(key: :wait_complete,
                                  env_name: "TESTDROID_RUNNER_WAIT_COMPLETE",
                                  description: "Whether to wait for the tests execution to be complete",
                                  optional: true,
                                  default_value: true,
                                  is_string: false),
          FastlaneCore::ConfigItem.new(key: :report_dir,
                                  env_name: "TESTDROID_RUNNER_REPORT_DIR",
                                  description: "The directory where to download the report files. If :wait_complete is false, this setting will be ignored",
                                  optional: true,
                                  type: String),
          FastlaneCore::ConfigItem.new(key: :concurrency,
                                  env_name: "TESTDROID_RUNNER_CONCURRENCY",
                                  description: "Number of purchased concurrency lanes. Testdroid jobs have a maximum device amount of 2x purchased lanes. The runner will split the selected lists into smaller runs in order to fit around this restriction",
                                  optional: true,
                                  type: Integer,
                                  default_value: 2),
          FastlaneCore::ConfigItem.new(key: :scheduler,
                                  env_name: "TESTDROID_RUNNER_SCHEDULER",
                                  description: "Which type of scheduler to use, by default it will only run one device at a time",
                                  optional: true,
                                  type: String,
                                  default_value: "SERIAL"),
          FastlaneCore::ConfigItem.new(key: :access_group,
                                  env_name: "TESTDROID_RUNNER_ACCESS_GROUP",
                                  description: "If present, will share uploaded files with the named access group",
                                  optional: true,
                                  type: String)
        ]
      end

      def self.is_supported?(platform)
        [:ios, :android].include?(platform)
      end
    end
  end
end
