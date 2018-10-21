module Fastlane
  module Actions
    module SharedValues
      GET_GLOBAL_VALUE_CUSTOM_VALUE = :GET_GLOBAL_VALUE_CUSTOM_VALUE
    end

    class GetGlobalValueAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:
        key = params[:key]
        Actions.lane_context[SharedValues::GET_GLOBAL_VALUE_CUSTOM_VALUE] = self.projectKey(key)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "A short description with <= 80 characters of what this action does"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "You can use this action to do cool things..."
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          ['key', 'The key for which to find a value'],
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['GET_GLOBAL_VALUE_CUSTOM_VALUE', 'A description of what this value contains']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["touyu"]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        #  true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
        # 

        platform == :ios
      end

      def self.projectKey(aKey)
        projectKey = ''
        filename = "fastlane/.fastlane_env"
        File.open(filename, "r:UTF-8") do |f|
          contents = f.read
          array = contents.split(" ")
          key = array[0]
          value = array[1]
          if key == aKey
            return value
          end
        end
      end
    end
  end
end
