$:.unshift File.dirname(__FILE__)

module AresMUSH
     module MoonPhase

    def self.plugin_dir
      File.dirname(__FILE__)
    end

    def self.shortcuts
      Global.read_config("moonphase", "shortcuts")
    end

  end
end