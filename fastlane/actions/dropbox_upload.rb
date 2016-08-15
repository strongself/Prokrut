require 'dropbox_sdk'

module Fastlane
  module Actions
    # Action for upload build to dropbox
    class DropboxUploadAction < Action
      TEMPLATE_PROJECTS_HTML_FILENAME = 'fastlane/assets/projects_index_template.html'.freeze
      TEMPLATE_PROJECT_HTML_FILENAME = 'fastlane/assets/project_index_template.html'.freeze
      TEMPLATE_PROJECT_PLIST_FILENAME = 'fastlane/assets/project_plist_template.plist'.freeze

      def self.run(params)
        # Authorization
        token = params[:dropbox_access_token]
        client = DropboxClient.new(token)

        # Set Paths
        ipa_path = params[:ipa_path]
        ipa = open(ipa_path)
        @project_path = params[:upload_path]
        project_name = 'Prokrut'
        upload_ipa_path = "#{@project_path}/#{project_name}.ipa"

        # Upload IPA
        client.put_file(upload_ipa_path, ipa, true)
        ipa_url = client.media(upload_ipa_path)['url']
        ipa_paths = ipa_url.split('/')
        ipa_url = "#{ipa_paths[5]}/#{ipa_paths.last}"

        # Gets info used for the plist
        info = FastlaneCore::IpaFileAnalyser.fetch_info_plist_file(ipa_path)
        bundle_id = info['CFBundleIdentifier']
        bundle_version = info['CFBundleShortVersionString']
        title = info['CFBundleName']

        # Asset path
        assets_path = "#{File.dirname(File.dirname(__FILE__))}/assets/"

        # grabs module
        eth = Fastlane::ErbTemplateHelper

        # Create temp path
        tmp_path = "/tmp/DropboxAction_#{project_name}"
        FileUtils.mkpath(tmp_path)

        # Creates plist from template
        plist_template = eth.load_from_path("#{assets_path}plist.erb")
        plist_render_option = {
          ipa_url: ipa_url,
          bundle_id: bundle_id,
          bundle_version: bundle_version,
          title: title
        }
        plist_render = eth.render(plist_template, plist_render_option)

        plist_name = "#{tmp_path}/#{project_name}.plist"
        plist = File.new(plist_name, 'w')
        plist.puts(plist_render.to_s)
        plist.close

        # Upload Plist
        plist = open(plist_name)
        plist_file_path = "#{@project_path}/#{project_name}.plist"
        client.put_file(plist_file_path, plist, true)
        plist_url = client.media(plist_file_path)['url']
        plist_paths = plist_url.split('/')
        plist_url = "#{plist_paths[5]}/#{plist_paths.last}"

        # Creates html from template
        html_template = eth.load_from_path("#{assets_path}index.erb")
        html_render_option = {
          plist_url: plist_url,
          title: title
        }
        html_render = eth.render(html_template, html_render_option)
        html_name = "#{tmp_path}/index.html"
        html = File.new(html_name, 'w')
        html.puts(html_render.to_s)
        html.close

        # Upload Html
        html = open(html_name)
        html_file_path = "#{@project_path}/index.html"
        client.put_file(html_file_path, html, true)
        client.shares(html_file_path)['url']
      end

      #####################################################
      # @!group Documentation
      #####################################################
      def self.description
        'Upload ipa to dropbox'
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :ipa_path,
                                       env_name: 'FL_RDS_DROPBOX_DEPLOY_IPA_PATH',
                                       description: 'Path to ipa file',
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :dropbox_access_token,
                                       env_name: 'FL_RDS_DROPBOX_ACCESS_TOKEN',
                                       description: 'DropBox api key',
                                       is_string: true),
          FastlaneCore::ConfigItem.new(key: :upload_path,
                                       env_name: 'FL_RDS_DROPBOX_UPLOAD_PATH',
                                       description: 'Upload path',
                                       is_string: true)
        ]
      end

      def self.authors
        ['CognitiveDisson']
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
