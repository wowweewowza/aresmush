module AresMUSH
  module FS3Skills
    class FocusResetCmd
      include CommandHandler      
      def handle
        FS3Skills.reset_focus(enactor, enactor_room.scene)
      end
    end
  end
end