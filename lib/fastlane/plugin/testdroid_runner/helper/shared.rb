require 'testdroid-api-client'
module Fastlane
  module Helper
    class TestdroidRunnerHelper
      @user = nil
      def self.get_user(params)
        if @user.nil?
          client = TestdroidAPI::ApikeyClient.new(params[:api_key])
          @user = client.authorize
        end
        @user
      end

      def self.get_os(params)
        if params[:application_file].end_with?(".apk")
          return { name: "ANDROID", framework: "s_osType_eq_ANDROID;s_name_like_%Instrumentation", extname: "apk" }
        end
        if params[:application_file].end_with?(".ipa", ".app")
          # XCTest would be return { name: "IOS", framework: "s_osType_eq_IOS;s_name_like_%XCTest", extname: "ipa" }
          return { name: "IOS", framework: "s_osType_eq_IOS;s_name_like_%XCUITest", extname: "ipa" }
        end
        raise "Unknown extension for #{params.application_file}"
      end

      def self.upload_file(file, access_group = nil)
        unless File.exist?(file)
          raise "[testdroid] File #{file} doesn't exist"
        end
        file_name = File.basename(file)
        duplicated_files = @user.files.list({ filter: "s_name_eq_#{file_name}" })
        unless duplicated_files.nil? || duplicated_files.length == 0
          puts("[testdroid] Deleting duplicated files with ids: #{duplicated_files.collect(&:id)}")
          duplicated_files.each(&:delete)
        end
        uploaded_file = @user.files.upload(file)
        if uploaded_file.nil?
          raise "[testdroid] Error uploading file"
        end
        puts("[testdroid] Uploaded: #{uploaded_file.id}")
        unless access_group.nil?
          group = @user.instance_variable_get(:@client).get('/cloud/api/v2/me/access-groups', { limit: 10, search: access_group })
          if group['data'].nil?
            raise "[testdroid] Access Group #{access_group} not found"
          end
          unless group['data'].count == 1
            raise "[testdroid] Too many access groups found for #{access_group}: #{group['data'].count}"
          end
          group_id = group['data'][0]['id']
          @user.instance_variable_get(:@client).post("/cloud/api/v2/me/files/#{uploaded_file.id}/share", { accessGroupId: group_id })
        end
        uploaded_file
      end
    end
  end
end
