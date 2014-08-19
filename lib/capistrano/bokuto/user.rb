require 'aws/iam'

module Capistrano
  module Bokuto
    class User
      attr_reader :client, :credentials

      def initialize aws={}
        access_key_id = aws.fetch(:access_key_id)
        secret_access_key = aws.fetch(:secret_access_key)

        @client = AWS::IAM.new(\
          :access_key_id => access_key_id,
          :secret_access_key => secret_access_key).client

        @credentials = @client.get_user
        self
      end

      def name
        credentials[:user][:user_name]
      end

    end
  end
end