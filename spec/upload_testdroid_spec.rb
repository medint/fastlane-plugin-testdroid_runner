describe Fastlane::Actions::UploadTestdroidAction do
  describe '#run' do
    it 'Uploads a test file' do
      Fastlane::Actions::UploadTestdroidAction.run({ api_key: ENV['TESTDROID_RUNNER_API_KEY'],
          application_file: ENV['TESTDROID_RUNNER_APPLICATION_FILE'], access_group: ENV['TESTDROID_RUNNER_ACCESS_GROUP'] })
    end
  end
end
