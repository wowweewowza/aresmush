module AresMUSH
  module Tinker
    class TinkerCmd
      include CommandHandler
      
      def check_can_manage
        return t('dispatcher.not_allowed') if !enactor.has_permission?("tinker")
        return nil
      end
      
      def handle
        char = Character.named("Testman")
        target_attr = char.fs3_attributes.detect { |a| a.name == "Wits" }
        client.emit target_attr&.rating
      end
    end
  end
end
