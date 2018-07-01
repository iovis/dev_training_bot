require 'google/apis/drive_v3'
require 'googleauth/stores/file_token_store'

module DevTrainingBot
  class GoogleDriveService
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
    APPLICATION_NAME = 'Dev Training Bot'.freeze
    CLIENT_SECRETS_PATH = ENV['CLIENT_SECRETS_PATH'].freeze
    CREDENTIALS_PATH = 'token.yaml'.freeze
    SCOPE = Google::Apis::DriveV3::AUTH_DRIVE_READONLY
    DOC_URL = "https://docs.google.com/document/d/#{ENV['FILE_ID']}".freeze
    FORMATS = {
      'html'        => 'text/html',
      'zip'         => 'application/zip',
      'text'        => 'text/plain',
      'rtf'         => 'application/rtf',
      'open_office' => 'application/vnd.oasis.opendocument.text',
      'pdf'         => 'application/pdf',
      'word'        => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'epub'        => 'application/epub+zip'
    }

    extend Forwardable

    def_delegators :@service, :export_file

    attr_reader :service

    def self.formats
      FORMATS.keys
    end

    def self.mime(format)
      FORMATS[format]
    end

    def initialize
      @service = Google::Apis::DriveV3::DriveService.new
      @service.client_options.application_name = APPLICATION_NAME
      @service.authorization = authorize
    end

    private

    ##
    # Ensure valid credentials, either by restoring from the saved credentials
    # files or intitiating an OAuth2 authorization. If authorization is required,
    # the user's default browser will be launched to approve the request.
    #
    # @return [Google::Auth::UserRefreshCredentials] OAuth2 credentials
    def authorize
      client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
      token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
      authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
      user_id = 'default'
      credentials = authorizer.get_credentials(user_id)

      if credentials.nil?
        url = authorizer.get_authorization_url(base_url: OOB_URI)

        puts 'Open the following URL in the browser and enter the ' \
          "resulting code after authorization:\n" + url
        code = gets

        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI
        )
      end

      credentials
    end
  end
end
