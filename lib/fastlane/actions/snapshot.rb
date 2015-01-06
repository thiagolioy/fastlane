module Fastlane
  module Actions
    module SharedValues
      SNAPSHOT_SCREENSHOTS_PATH = :SNAPSHOT_SCREENSHOTS_PATH
    end


    def self.snapshot(params)
      execute_action("snapshot") do
        require 'snapshot'

        clean = true
        clean = false if params.first == :noclean

        if Helper.is_test?
          self.lane_context[SharedValues::SNAPSHOT_SCREENSHOTS_PATH] = Dir.pwd
          return clean 
        end

        Snapshot::SnapshotConfig.shared_instance
        Snapshot::Runner.new.work(clean: clean)

        results_path = Snapshot::SnapshotConfig.shared_instance.screenshots_path

        self.lane_context[SharedValues::SNAPSHOT_SCREENSHOTS_PATH] = File.expand_path(results_path) # absolute URL
      end
    end
  end
end