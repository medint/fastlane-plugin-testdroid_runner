require_relative './shared'

module Fastlane
  module Helper
    class RunTest
      def self.run(params)
        # source: https://github.com/bitbar/testdroid-api-client-ruby/blob/master/sample/sample.rb
        user = Helper::TestdroidRunnerHelper.get_user(params)
        os_config = Helper::TestdroidRunnerHelper.get_os(params)
        puts("[testdroid] Starting test run with:\napp #{os_config[:extname]}: #{params[:application_file]}\ntest #{os_config[:extname]}: #{params[:test_file]}")
        # Create project
        project = user.projects.list.detect { |proj| proj.name.casecmp(params[:project]) == 0 }

        # get all the devices to run on
        device_group = user.device_groups.list.detect { |group| group.display_name.casecmp(params[:device_group]) == 0 }
        run_devices = device_group.devices.list_all.select { |device| device.os_type.casecmp(os_config[:name]) == 0 }
        puts("[testdroid] Running on devices #{run_devices.collect(&:display_name)}")
        # get IDs of the devices
        id_list = run_devices.collect(&:id)

        # get the framework id
        framework_id = user.available_frameworks.list({ filter: os_config[:framework] })[0].id

        # Upload file
        puts("[testdroid] Uploading app #{os_config[:extname]}...")
        file_app = Helper::TestdroidRunnerHelper.upload_file(params[:application_file], params[:access_group])
        # instrumentation package
        puts("[testdroid] Uploading test #{os_config[:extname]}...")
        file_test = Helper::TestdroidRunnerHelper.upload_file(params[:test_file], params[:access_group])

        i = 0
        until id_list[i, i + params[:concurrency] * 2].nil?
          list = id_list[i, i + params[:concurrency] * 2]
          i += params[:concurrency] * 2
          # start test run
          test_run = user.runs.create("{\"osType\": \"#{os_config[:name]}\", \"projectId\": #{project.id}, \"frameworkId\":#{framework_id},
              \"deviceIds\": #{list}, \"scheduler\": \"#{params[:scheduler] || 'SERIAL'}\", \"timeout\": \"#{params[:timeout]}\", \"files\": [{\"id\": #{file_app.id}, \"action\": \"INSTALL\" },
              {\"id\": #{file_test.id}, \"action\": \"RUN_TEST\" }]}")
          puts("[testdroid] Started test run, access it using this link: https://cloud.bitbar.com/#testing/projects/#{project.id}/#{test_run.id}")

          # wait until the whole test run is completed
          next unless params[:wait_complete]
          until test_run.refresh.state == "FINISHED"
            print(".")
            sleep(20)
          end

          print("\n")

          puts("[testdroid] Test run finished with success ratio: #{test_run.success_ratio * 100}% [executed:#{test_run.execution_ratio * 100}%]")
          # download all files from all device sessions

          next unless params[:report_dir]
          puts("[testdroid] Downloading files...")
            test_run.device_sessions.list_all().each { |tr|
              begin
                downloaded_file = "#{params[:report_dir]}/#{tr.id()}.zip"
                user.instance_variable_get(:@client)
                  .download("/cloud/api/v2/me/device-sessions/#{tr.id()}/output-file-set/files.zip", downloaded_file)
                puts("[testdroid] Downloaded file for #{tr.device["displayName"]} (device session #{tr.id()}) as #{downloaded_file}")
              rescue
                puts("[testdroid] No files available for #{tr.device["displayName"]} (device session #{tr.id()})")
              end
            }
          puts("[testdroid] All files downloaded")
        end
      ensure
        puts("[testdroid] Cleaning up...")
        file_app.delete unless file_app.nil?
        file_test.delete unless file_test.nil?
      end
    end
  end
end
