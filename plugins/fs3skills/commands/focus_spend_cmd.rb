module AresMUSH
  module FS3Skills
    class FocusSpendCmd
      include CommandHandler
      
      attr_accessor :amount
      attr_accessor :reason

      def parse_args
        self.reason = trim_arg(cmd.args)
      end

      def required_args
        [ self.reason ]
      end
      
      def check_focus
        return t('fs3skills.not_enough_focus') if enactor.focus < 1
        return nil
      end
      
      def handle
        FS3Skills.spend_focus(enactor, self.amount, self.reason, enactor_room.scene)
      end
    end
  end
end