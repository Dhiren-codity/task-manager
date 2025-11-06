require "active_record"

module TaskManagerApi
  class Application
    def self.root
      File.expand_path("../..", __FILE__)
    end
  end
end
