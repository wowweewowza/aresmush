module AresMUSH
  module FS3Skills
    class FocusSpendCmd
      include CommandHandler
      
      attr_accessor :amount, :reason

      def parse_args
        args = cmd.parse_args(ArgParser.arg1_slash_arg2)
        self.amount = integer_arg(args.arg1)
        self.reason = args.arg2
      end

      def required_args
        [ self.amount, self.reason ]
      end
      
      def check_amount
        return t('fs3skills.invalid_focus_points') if self.amount == 0
        return nil
      end
      
      def handle
        FS3Skills.spend_focus(enactor, self.amount, self.reason, enactor_room.scene)
      end
    end
  end
end