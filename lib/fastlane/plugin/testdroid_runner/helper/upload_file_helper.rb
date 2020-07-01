require_relative './shared'

module Fastlane
  module Helper
    class UploadFile
      def self.run(params)
        Helper::TestdroidRunnerHelper.get_user(params)
        os_config = Helper::TestdroidRunnerHelper.get_os(params)
        puts("[testdroid] Uploading #{os_config[:extname]} for live services: #{params[:application_file]}...")
        file_app = Helper::TestdroidRunnerHelper.upload_file(params[:application_file])

        puts("[testdroid] Test the app on a live device: https://cloud.bitbar.com/#testing/interactive-choose-device")
        file_app.id
      end
    end
  end
end
