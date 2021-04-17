require 'fastlane/action'
require_relative '../helper/upload_file_helper'

module Fastlane
  module Actions
    class UploadTestdroidAction < Action
      def self.run(params)
        $stdout.sync = true
        Helper::UploadFile.run(params)
      end

      def self.description
        "Uploads a file to bitbar"
      end

      def self.authors
        ["josepmc"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
        "Returns the uploaded file id"
      end

      def self.details
        # Optional:
        "Uploads a file to bitbar"
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
