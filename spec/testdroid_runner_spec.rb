describe Fastlane::Actions::TestdroidRunnerAction do
  describe '#run' do
    it 'Runs a sample test' do
      Fastlane::Actions::TestdroidRunnerAction.run({ api_key: ENV['TESTDROID_RUNNER_API_KEY'],
          application_file: ENV['TESTDROID_RUNNER_APPLICATION_FILE'], test_file: ENV['TESTDROID_RUNNER_TEST_FILE'],
          project: ENV['TESTDROID_RUNNER_PROJECT'], device_group: ENV['TESTDROID_RUNNER_DEVICE_GROUP'], access_group: ENV['TESTDROID_RUNNER_ACCESS_GROUP'],
          wait_complete: true, report_dir: ENV['TESTDROID_RUNNER_REPORT_DIR'], concurrency: 2 })
    end
  end
end
